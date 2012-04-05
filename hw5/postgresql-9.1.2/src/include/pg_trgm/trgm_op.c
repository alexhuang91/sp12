/*
 * contrib/pg_trgm/trgm_op.c
 */
#include "postgres.h"

#include <ctype.h>
#include <math.h>

#include "trgm.h"

#include "catalog/pg_type.h"
#include "tsearch/ts_locale.h"
#include "utils/array.h"


PG_MODULE_MAGIC;

float4 trgm_limit = 0.3f; 

PG_FUNCTION_INFO_V1(set_limit);
Datum set_limit(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(show_limit);
Datum show_limit(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(show_trgm);
Datum show_trgm(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(similarity);
Datum similarity(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(similarity_dist);
Datum similarity_dist(PG_FUNCTION_ARGS);

PG_FUNCTION_INFO_V1(similarity_op);
Datum similarity_op(PG_FUNCTION_ARGS);

int cmpchar(char a, char b) {
  if (a == b)
    return 0;
  else if (a < b)
    return -1;
  else
    return 1;
}

int cmppchar(trgm *a, trgm *b, int i) {
  return cmpchar( *(((char*)(a))+i), *(((char*)(b))+i) );
}

//FIXME: Generalize this to q-grams
int cmptrgm(trgm *a, trgm *b) {
  int i;

  for (i=0; i < trgm_size;i++) {
    if (cmppchar(a,b,i)) {
      return cmppchar(a,b,i);
    }
  }
  return 0;
}

//FIXME: Generalize this to q-grams
// *a is an array of pointers to trgms
void cptrgm(trgm *a, trgm *b) {
  int i;
  for (i=0; i < trgm_size; i ++) {
    *(((char*)(a))+i) = *(((char*)(b))+i);
  }
}


int pincount = 0;
// Converts a q-gram to a string representation.
// TODO(anirudh) Maybe change this so it only does trigrams?
// Input:
//   Pointer to the beginning of a trgm.
// Output:
//   A string that looks like [c, a, t] for the trigram "cat".
//   (This should help see whitespace or failures.)
// WARNING: This function reuses the same memory, so calling it again will
//   overwrite the last returned string!! Be sure to use it before then!
char* qgram_buffer = 0; // hack to prevent leaking mem
char* qgram_to_s(trgm* t) {
  int i;
  // Allocate memory for our return string.
  // We need 3 chars for [, ], and \0 (null char at the end), and
  // 3 char per letter in trigram, EXCEPT the last one, where we only need 1 char.
  // Therefore, 3 + 3*q - 2 = 1+3*q.
  char* s = qgram_buffer;
  s[0] = '[';

  // Loop through each q-gram and insert str of form "X, "
  // into the proper place of our char*.
  for (i = 0; i < q; i ++) {
    // s+1+3*i = (base ptr) + ('[' char) + (3 chars per letter in q-gram)
    sprintf(s+1+3*i, "%c, ", *((char*)t+i));
  }

  s[-1+3*q] = ']'; // lol, C. I'm overwriting the last ", " with "]\0".
  s[0 +3*q] = '\0';

  return s;
}

// Converts a contiguous block of qgrams to a string representation.
// Input:
//   Pointer to the beginning of the list of trgms.
// Output:
//   A string that looks like { [ , c, a], [c, a, t], ... }
// WARNING: This function reuses the same memory, so calling it again will
//   overwrite the last returned string!! Be sure to use it before then!
char* allgrams_buffer = 0;
char* all_grams_to_s(trgm* trgms, int num_trgms) {
  int i;
  char *s = allgrams_buffer;
  char* cur_str;
  s[0] = '{';
  s[1] = ' ';

  cur_str = s + 2;
  for(i = 0; i < num_trgms; i++) {
    char* ith_gram = qgram_to_s(trgms+trgm_size*i);
    sprintf(cur_str, "%s, ", ith_gram); 
    cur_str += strlen(ith_gram) + 2; // strlen doesn't include \0, which is good
  }

  // lol C
  cur_str[-2] = ' ';
  cur_str[-1] = '}';
  cur_str[0] = '\0';

  return s;
}

Datum
set_limit(PG_FUNCTION_ARGS)
{
  float4 nlimit = PG_GETARG_FLOAT4(0);

  if (nlimit < 0 || nlimit > 1.0)
    elog(ERROR, "wrong limit, should be between 0 and 1");
  trgm_limit = nlimit;
  PG_RETURN_FLOAT4(trgm_limit);
}

Datum
show_limit(PG_FUNCTION_ARGS)
{
  PG_RETURN_FLOAT4(trgm_limit);
}

static int
comp_trgm(const void *a, const void *b)
{
  return cmptrgm((trgm*)a, (trgm*)b);
}

// *a is an array of pointers to trigrams
static int
unique_array(trgm *a, int len)
{
  trgm *curend, *tmp;

  curend = tmp = a;
  while (tmp - a < len)
    if (cmptrgm(tmp, curend))
      {
	curend+=trgm_size;
	cptrgm(curend, tmp);
	tmp+=trgm_size;
      }
    else {
      tmp+=trgm_size;
    }

  return curend + trgm_size - a;
}

#ifdef KEEPONLYALNUM
#define iswordchr(c) (t_isalpha(c) || t_isdigit(c))
#else
#define iswordchr(c) (!t_isspace(c))
#endif

/*
 * Finds first word in string, returns pointer to the word,
 * endword points to the character after word
 */
static char *
find_word(char *str, int lenstr, char **endword, int *charlen)
{
  char *beginword = str;

  while (beginword - str < lenstr && !iswordchr(beginword))
    beginword += pg_mblen(beginword);

  if (beginword - str >= lenstr)
    return NULL;

  *endword = beginword;
  *charlen = 0;
  while (*endword - str < lenstr && iswordchr(*endword))
    {
      *endword += pg_mblen(*endword);
      (*charlen)++;
    }

  return beginword;
}

/*
 * Makes trigrams from words (already padded).
 */
static trgm *
make_trigrams(trgm *tptr, char *str, int bytelen, int charlen)
{
  char *ptr = str;
  int i;

  // FIXME: If len(word) < q, return the word as a q-gram - not an empty pointer!
  if (charlen < q){
    append_trgm(tptr, ptr, 3+charlen); // SHUT UP. MY FLAGS IS 3+charlen.
    //    elog(LOG, "WARNING:  charlen<3 not implemented");
    return tptr + trgm_size;
  }

  Assert(bytelen == charlen);

  // FIXME: Generalize the code below to q-grams. 
  // HINT: Keep in mind the two additional rules that only affect the first formed q-gram

  char *x = palloc(trgm_size);
  *x = *ptr;
  *(x+1) = ' ';
  for (i = 2; i < q; i ++) {
    *(x+i) = ' ';
  }
  append_trgm(tptr, x, 1);
  tptr += trgm_size;
  append_trgm(tptr, ptr, 2);
  tptr += trgm_size;

  pfree(x);

  while (ptr - str < bytelen - q + 1 /* number of trigrams = strlen - 2 */ )
    {
      //      cptrgm(tptr, (trgm*) ptr);
      append_trgm(tptr, ptr, 0);
      elog(LOG, "Made trigram: %s", qgram_to_s(tptr));
      ptr++;
      tptr+=trgm_size;
    }
 
  return tptr;
}

// flags:
// 0: nothing
// 1: #
// 2: !
void append_trgm(trgm* tptr, char* src, int flags) {
  int i;

  int len = q;

  if (flags >= 3) {
    len = flags - 3;
    flags = 3;
  }

  for (i = 0; i < q; i ++) {
    if (i < len) {
      *((char*)tptr + i) = *(src+i);
    } else {
      *((char*)tptr + i) = 0;
    }
  }

  *((char*)tptr+q) = flags;
}

TRGM *
generate_trgm(char *str, int slen)
{
  TRGM *trg;
  char *buf;
  trgm *tptr;
  int len, charlen, bytelen;
  char *bword, *eword;

  // FIXME: What size should we allocate?
  trg = (TRGM *) palloc(TRGMHDRSIZE + trgm_size * (slen / 2 + 1) *3);
  trg->flag = ARRKEY;
  SET_VARSIZE(trg, TRGMHDRSIZE);


  //  elog(LOG, "Hi with str=%s, q=%d", str,q);
  // TODO(anirudh) Comment here or remove?
  //if (slen < q || slen == 0)
    //    return trg;

  tptr = GETARR(trg);

  buf = palloc(sizeof(char) * (slen + trgm_size + 1 + 1));

  eword = str;
  while ((bword = find_word(eword, slen - (eword - str), &eword, &charlen)) != NULL)
    {
#ifdef IGNORECASE
      bword = lowerstr_with_len(bword, eword - bword);
      bytelen = strlen(bword);
#else
      bytelen = eword - bword;
#endif

      memcpy(buf, bword, bytelen);

#ifdef IGNORECASE
      pfree(bword);
#endif

      /*
       * count trigrams
       */
      //      elog(LOG, "Inc buf=%d %c", buf, *buf);
      tptr = make_trigrams(tptr, buf, bytelen, charlen);
    }

  //  elog(LOG, "Out buf=%d %c", buf, *buf);
  //  elog(LOG, "Prepare free");
  pfree(buf);
  //  elog(LOG, "Free complete");

  if ((len = tptr - GETARR(trg)) == 0)
    return trg;

  if (len > 0)
    {
      //      elog(LOG, "len=%d", len);
      elog(LOG, "Beginning trigram: %s", all_grams_to_s(GETARR(trg), len/trgm_size));
      qsort((void *) GETARR(trg), len/trgm_size, trgm_size, comp_trgm);
      elog(LOG, "Sorted trigram: %s", all_grams_to_s(GETARR(trg), len/trgm_size));
      len = unique_array(GETARR(trg), len);
      elog(LOG, "Unique trigrams(%d): %s", len/trgm_size, all_grams_to_s(GETARR(trg), len/trgm_size));
    }

  SET_VARSIZE(trg, CALCGTSIZE(ARRKEY, len/trgm_size));

  return trg;
} // END generate_trgm

/*
 * Extract the next non-wildcard part of a search string, ie, a word bounded
 * by '_' or '%' meta-characters, non-word characters or string end.
 *
 * str: source string, of length lenstr bytes (need not be null-terminated)
 * buf: where to return the substring (must be long enough)
 * *bytelen: receives byte length of the found substring
 * *charlen: receives character length of the found substring
 *
 * Returns pointer to end+1 of the found substring in the source string.
 * Returns NULL if no word found (in which case buf, bytelen, charlen not set)
 *
 * If the found word is bounded by non-word characters or string boundaries
 * then this function will include corresponding padding spaces into buf.
 */
static const char *
get_wildcard_part(const char *str, int lenstr,
		  char *buf, int *bytelen, int *charlen)
{
  const char *beginword = str;
  const char *endword;
  char   *s = buf;
  bool in_wildcard_meta = false;
  bool in_escape = false;
  int clen;

  /*
   * Find the first word character remembering whether last character was
   * wildcard meta-character.
   */
  while (beginword - str < lenstr)
    {
      if (in_escape)
	{
	  in_escape = false;
	  in_wildcard_meta = false;
	  if (iswordchr(beginword))
	    break;
	}
      else
	{
	  if (ISESCAPECHAR(beginword))
	    in_escape = true;
	  else if (ISWILDCARDCHAR(beginword))
	    in_wildcard_meta = true;
	  else if (iswordchr(beginword))
	    break;
	  else
	    in_wildcard_meta = false;
	}
      beginword += pg_mblen(beginword);
    }

  /*
   * Handle string end.
   */
  if (beginword - str >= lenstr)
    return NULL;

  /*
   * Add left padding spaces if last character wasn't wildcard
   * meta-character.
   */
  *charlen = 0;
  if (!in_wildcard_meta)
    {
      if (LPADDING > 0)
	{
	  *s++ = ' ';
	  (*charlen)++;
	  if (LPADDING > 1)
	    {
	      *s++ = ' ';
	      (*charlen)++;
	    }
	}
    }

  /*
   * Copy data into buf until wildcard meta-character, non-word character or
   * string boundary.  Strip escapes during copy.
   */
  endword = beginword;
  in_wildcard_meta = false;
  in_escape = false;
  while (endword - str < lenstr)
    {
      clen = pg_mblen(endword);
      if (in_escape)
	{
	  in_escape = false;
	  in_wildcard_meta = false;
	  if (iswordchr(endword))
	    {
	      memcpy(s, endword, clen);
	      (*charlen)++;
	      s += clen;
	    }
	  else
	    break;
	}
      else
	{
	  if (ISESCAPECHAR(endword))
	    in_escape = true;
	  else if (ISWILDCARDCHAR(endword))
	    {
	      in_wildcard_meta = true;
	      break;
	    }
	  else if (iswordchr(endword))
	    {
	      memcpy(s, endword, clen);
	      (*charlen)++;
	      s += clen;
	    }
	  else
	    {
	      in_wildcard_meta = false;
	      break;
	    }
	}
      endword += clen;
    }

  /*
   * Add right padding spaces if last character wasn't wildcard
   * meta-character.
   */
  if (!in_wildcard_meta)
    {
      if (RPADDING > 0)
	{
	  *s++ = ' ';
	  (*charlen)++;
	  if (RPADDING > 1)
	    {
	      *s++ = ' ';
	      (*charlen)++;
	    }
	}
    }

  *bytelen = s - buf;
  return endword;
}

/*
 * Generates trigrams for wildcard search string.
 *
 * Returns array of trigrams that must occur in any string that matches the
 * wildcard string.  For example, given pattern "a%bcd%" the trigrams
 * " a", "bcd" would be extracted.
 */
TRGM *
generate_wildcard_trgm(const char *str, int slen)
{
  TRGM *trg;
  char *buf, *buf2;
  trgm *tptr;
  int len, charlen, bytelen;
  const char *eword;

  trg = (TRGM *) palloc(TRGMHDRSIZE + trgm_size * (slen / 2 + 1) *3);
  trg->flag = ARRKEY;
  SET_VARSIZE(trg, TRGMHDRSIZE);

  if (slen + LPADDING + RPADDING < 3 || slen == 0)
    return trg;

  tptr = GETARR(trg);

  buf = palloc(sizeof(char) * (slen + 4));

  /*
   * Extract trigrams from each substring extracted by get_wildcard_part.
   */
  eword = str;
  while ((eword = get_wildcard_part(eword, slen - (eword - str),
				    buf, &bytelen, &charlen)) != NULL)
    {
#ifdef IGNORECASE
      buf2 = lowerstr_with_len(buf, bytelen);
      bytelen = strlen(buf2);
#else
      buf2 = buf;
#endif

      /*
       * count trigrams
       */
      tptr = make_trigrams(tptr, buf2, bytelen, charlen);
#ifdef IGNORECASE
      pfree(buf2);
#endif
    }

  pfree(buf);

  if ((len = tptr - GETARR(trg)) == 0)
    return trg;

  /*
   * Make trigrams unique.
   */
  if (len > 0)
    {
      qsort((void *) GETARR(trg), len, sizeof(trgm), comp_trgm);
      len = unique_array(GETARR(trg), len);
    }

  SET_VARSIZE(trg, CALCGTSIZE(ARRKEY, len));

  return trg;
}

uint32
trgm2int(trgm *ptr)
{
  uint32 val = 0;

  val |= *(((unsigned char *) ptr));
  val <<= 8;
  val |= *(((unsigned char *) ptr) + 1);
  val <<= 8;
  val |= *(((unsigned char *) ptr) + 2);

  return val;
}

Datum
show_trgm(PG_FUNCTION_ARGS)
{
  //  elog(LOG, "Hi!");
  text *in = PG_GETARG_TEXT_P(0);
  TRGM *trg;
  Datum *d;
  ArrayType *a;
  trgm *ptr;
  int i;
  int slen = VARSIZE(in) - VARHDRSZ;

  // allocate static memory for our print functions
  // sorry for this hack -- I just didn't want you guys to have to
  // deal with deallocating the returned strings!
  qgram_buffer = palloc(1 + 3*q);
  allgrams_buffer = palloc(5 + (1+3*q)*(slen + 2));

  trg = generate_trgm(VARDATA(in), slen);
  d = (Datum *) palloc(sizeof(Datum) * (1 + ARRNELEM(trg)));
  //  elog(LOG, "!show_trgm knows the arrlen is %d (%d %d %d)", ARRNELEM(trg), VARSIZE(trg), TRGMHDRSIZE, q);

  // TODO(anirudh) This needs a FIXME too, maybe
  for (i = 0, ptr = GETARR(trg); i < ARRNELEM(trg); i++, ptr+=trgm_size)
    {
      // FIXME: Change the code below to take into account the new rules we have added for variable sized q-grams.
      // FIXME: Remember - donot print the whitespace you may have padded after the q-gram.
      // TODO(anirudh): Put hint about what this does
      text *item = (text *) palloc(VARHDRSZ + Max(12, pg_database_encoding_max_length() * trgm_size));

      int flag =  *((char*)ptr+q);
      if (flag == 0) {
	SET_VARSIZE(item, VARHDRSZ + q);
	cptrgm((trgm*) VARDATA(item), ptr);
      } else if (flag == 1) {
	SET_VARSIZE(item, VARHDRSZ + 2);
	cptrgm((trgm*) VARDATA(item), ptr);
	*(((char*)VARDATA(item))+1) = '#';
      } else if (flag == 2) {
	SET_VARSIZE(item, VARHDRSZ + trgm_size);
	cptrgm((trgm*) VARDATA(item), ptr);
	*(((char*)VARDATA(item))+q) = '!';
      } else if (flag == 3) {
	SET_VARSIZE(item, VARHDRSZ + q);
	cptrgm((trgm*) VARDATA(item), ptr);
      }
      //      elog(LOG, "Exporting %s %d", qgram_to_string((trgm*)VARDATA(item)), *((char*)ptr+q));
      
      d[i] = PointerGetDatum(item);
    }
  //  elog(LOG, "Export complete");

  a = construct_array(
		      d,
		      ARRNELEM(trg),
		      TEXTOID,
		      -1,
		      false,
		      'i'
		      );

  for (i = 0; i < ARRNELEM(trg); i++)
    pfree(DatumGetPointer(d[i]));

  pfree(d);
  pfree(trg);
  pfree(qgram_buffer);
  pfree(allgrams_buffer);

  PG_FREE_IF_COPY(in, 0);
  PG_RETURN_POINTER(a);
}

float4
cnt_sml(TRGM *trg1, TRGM *trg2)
{
  trgm *ptr1, *ptr2;
  int count = 0;
  int len1, len2;

  ptr1 = GETARR(trg1);
  ptr2 = GETARR(trg2);

  len1 = ARRNELEM(trg1);
  len2 = ARRNELEM(trg2);

  while (ptr1 - GETARR(trg1) < len1*trgm_size && ptr2 - GETARR(trg2) < len2*trgm_size)
    {
      int res = cmptrgm(ptr1, ptr2);
      //      elog(LOG, "Comparing %s & %s: %d", qgram_to_string(ptr1), qgram_to_string(ptr2), res);

      if (res < 0)
	ptr1+=trgm_size;
      else if (res > 0)
	ptr2+=trgm_size;
      else
	{
	  ptr1+=trgm_size;
	  ptr2+=trgm_size;
	  count++;
	}
    }
  return (((float) count) / ((float) ((len1 > len2) ? len1 : len2)));
}

/*
 * Returns whether trg2 contains all trigrams in trg1.
 * This relies on the trigram arrays being sorted.
 */
bool
trgm_contained_by(TRGM *trg1, TRGM *trg2)
{
  trgm  *ptr1, *ptr2;
  int len1, len2;

  ptr1 = GETARR(trg1);
  ptr2 = GETARR(trg2);

  len1 = ARRNELEM(trg1);
  len2 = ARRNELEM(trg2);

  while (ptr1 - GETARR(trg1) < len1 && ptr2 - GETARR(trg2) < len2)
    {
      int res = cmptrgm(ptr1, ptr2);

      if (res < 0)
	return false;
      else if (res > 0)
	ptr2++;
      else
	{
	  ptr1++;
	  ptr2++;
	}
    }
  if (ptr1 - GETARR(trg1) < len1)
    return false;
  else
    return true;
}

Datum
similarity(PG_FUNCTION_ARGS)
{
  text *in1 = PG_GETARG_TEXT_P(0);
  text *in2 = PG_GETARG_TEXT_P(1);
  TRGM *trg1, *trg2;
  float4 res;
  int max_slen = Max(VARSIZE(in1), VARSIZE(in2)) - VARHDRSZ;

  // allocate static memory for our print functions
  // sorry for this hack -- I just didn't want you guys to have to
  // deal with deallocating the returned strings!
  qgram_buffer = palloc(1 + 3*q);
  allgrams_buffer = palloc(5 + (1+3*q)*(max_slen + 2));

  trg1 = generate_trgm(VARDATA(in1), VARSIZE(in1) - VARHDRSZ);
  trg2 = generate_trgm(VARDATA(in2), VARSIZE(in2) - VARHDRSZ);

  res = cnt_sml(trg1, trg2);

  pfree(trg1);
  pfree(trg2);
  pfree(qgram_buffer);
  pfree(allgrams_buffer);
  PG_FREE_IF_COPY(in1, 0);
  PG_FREE_IF_COPY(in2, 1);

  PG_RETURN_FLOAT4(res);
}

Datum
similarity_dist(PG_FUNCTION_ARGS)
{
  float4 res = DatumGetFloat4(DirectFunctionCall2(similarity,
						  PG_GETARG_DATUM(0),
						  PG_GETARG_DATUM(1)));

  PG_RETURN_FLOAT4(1.0 - res);
}

Datum
similarity_op(PG_FUNCTION_ARGS)
{
  float4 res = DatumGetFloat4(DirectFunctionCall2(similarity,
						  PG_GETARG_DATUM(0),
						  PG_GETARG_DATUM(1)));

  PG_RETURN_BOOL(res >= trgm_limit);
}
