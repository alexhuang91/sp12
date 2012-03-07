/*
 * contrib/pg_trgm/trgm_op.c
 */
#include "postgres.h"

#include <ctype.h>

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

/* lexicographically compares two characters */
int cmpchar(char a, char b) {
  if (a == b)
    return 0;
  else if (a < b)
    return -1;
  else
    return 1;
}

/* lexicographically compares two characters at a particular index */
int cmppchar(trgm *a, trgm *b, int i) {
  return cmpchar( *(((char*)(a))+i), *(((char*)(b))+i) );
}

/* lexicographically compares two trigrams */
//FIXME: Generalize this to q-grams
int cmptrgm(trgm *a, trgm *b) {
  int i;
  int result;

  for (i=0; i< 3;i++) {
    if ((result = cmppchar(a,b,i)))
      return result;
  }
  return 0;
}

//FIXME: Generalize this to q-grams
void cptrgm(trgm *a, trgm *b) {
  *(((char*)(a))+0) = *(((char*)(b))+0);
  *(((char*)(a))+1) = *(((char*)(b))+1);
  *(((char*)(a))+2) = *(((char*)(b))+2);
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

/**
 * Uniques an array of trigrams in place by copying the unique trigrams to the beginning of the array
 * Input: 
 *   a: A pointer to the beginning of a trigram array
 *   num_grams: number of trigrams in the array a
 * Output:
 *   An integer representing the length occupied by the unique trigrams
 */
static int
unique_array(trgm *a, int num_grams)
{
  trgm *curend, *tmp;

  // curend will point to the last unique trigram seen
  // tmp will point to the next trigram under consideration

  // initialize by pointing everything to the beginning of the array a
  curend = tmp = a;
  // FIXME: sizeof(trgm) needs to be generalized
  while (RANGE_IN_BYTES(a,tmp) < num_grams*sizeof(trgm))
    if (cmptrgm(tmp, curend))
      {
	SCOOT_TRIGRAM_RIGHT(curend);
	cptrgm(curend, tmp);
	SCOOT_TRIGRAM_RIGHT(tmp);
      }
    else
      SCOOT_TRIGRAM_RIGHT(tmp);

  // FIXME: sizeof(trgm)
  return ((RANGE_IN_BYTES(a, (char*)curend)) / sizeof(trgm)) + 1;
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
    /**
     * pg_mblen() tells us how many bytes are used in the database's encoding.
     * Since our locale is set to "C", this will always return 1
     */
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

  // FIXME: If len(word) < q, return the word as a q-gram - not an empty pointer!
  if (charlen < 3)
    return tptr;

  Assert(bytelen == charlen);

  // FIXME: Generalize the code below to q-grams. 
  // NOTE: Keep in mind the two additional rules that only affect the first formed q-gram
  while (ptr - str < bytelen - 2)
    {
      cptrgm(tptr, (trgm*) ptr);
      ptr++;
      SCOOT_TRIGRAM_RIGHT(tptr);
    }
 
  return tptr;
}

TRGM *
generate_trgm(char *str, int slen)
{
  TRGM *trg;
  char *buf;
  trgm *tptr;
  int len, charlen, bytelen;
  char *bword, *eword;

  // FIXME: sizeof(trgm)
  // FIXME - Also, how many trigrams do we make per string under the new rules, max?
  trg = (TRGM *) palloc(TRGMHDRSIZE + sizeof(trgm) * (slen + 4));
  trg->flag = ARRKEY;
  SET_VARSIZE(trg, TRGMHDRSIZE);

  tptr = GETARR(trg);

  // FIXME - what size buf do we need under the new rules?
  buf = palloc(sizeof(char) * (slen + 4));
  // FIXME - Remove the padding logic
  if (LPADDING > 0)
    {
      *buf = ' ';
      if (LPADDING > 1)
	*(buf + 1) = ' ';
    }

  eword = str;
  while ((bword = find_word(eword, slen - (eword - str), &eword, &charlen)) != NULL)
    {
      bword = lowerstr_with_len(bword, eword - bword);
      bytelen = strlen(bword);

      // FIXME - Remove the padding logic
      memcpy(buf + LPADDING, bword, bytelen);

      pfree(bword);

      // FIXME - Remove the padding logic
      buf[LPADDING + bytelen] = ' ';
      buf[LPADDING + bytelen + 1] = ' ';

      // FIXME - Remove the padding logic
      tptr = make_trigrams(tptr, buf, bytelen + LPADDING + RPADDING,
			   charlen + LPADDING + RPADDING);
    }

  pfree(buf);

  // FIXME: sizeof(trgm)
  len = RANGE_IN_BYTES(GETARR(trg), tptr) / sizeof(trgm);
  if (len == 0)
    return trg;

  if (len > 0)
    {	
      // FIXME: sizeof(trgm)
      qsort((void *) GETARR(trg), len, sizeof(trgm), comp_trgm);
      len = unique_array(GETARR(trg), len);
    }

  SET_VARSIZE(trg, CALCGTSIZE(ARRKEY, len));

  return trg;
}

Datum
show_trgm(PG_FUNCTION_ARGS)
{
  text *in = PG_GETARG_TEXT_P(0);
  TRGM *trg;
  Datum *d;
  ArrayType *a;
  trgm *ptr;
  int i;

  trg = generate_trgm(VARDATA(in), VARSIZE(in) - VARHDRSZ);
  d = (Datum *) palloc(sizeof(Datum) * (1 + ARRNELEM(trg)));

  for (i = 0, ptr = GETARR(trg); i < ARRNELEM(trg); i++, SCOOT_TRIGRAM_RIGHT(ptr))
    {
      // FIXME: sizeof(trgm)
      text *item = (text *) palloc(VARHDRSZ + sizeof(trgm));
      // FIXME: sizeof(trgm)
      SET_VARSIZE(item, VARHDRSZ + sizeof(trgm));
      cptrgm((trgm*) VARDATA(item), ptr);
      
      d[i] = PointerGetDatum(item);
    }

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
  PG_FREE_IF_COPY(in, 0);

  PG_RETURN_POINTER(a);
}

float4
cnt_sml(TRGM *trg1, TRGM *trg2)
{
  trgm *ptr1, *ptr2;
  int count = 0;
  int nelem1, nelem2;

  ptr1 = GETARR(trg1);
  ptr2 = GETARR(trg2);

  nelem1 = ARRNELEM(trg1);
  nelem2 = ARRNELEM(trg2);

  // FIXME: sizeof(trgm)
  while (RANGE_IN_BYTES(GETARR(trg1), ptr1) < (nelem1 * sizeof(trgm)) 
         && RANGE_IN_BYTES(GETARR(trg2), ptr2) < (nelem2 * sizeof(trgm)))
    {
      int res = cmptrgm(ptr1, ptr2);

      if (res < 0)
	SCOOT_TRIGRAM_RIGHT(ptr1);
      else if (res > 0)
	SCOOT_TRIGRAM_RIGHT(ptr2);
      else
	{
	  SCOOT_TRIGRAM_RIGHT(ptr1);
	  SCOOT_TRIGRAM_RIGHT(ptr2);
	  count++;
	}
    }
  return (((float) count) / ((float) ((nelem1 > nelem2) ? nelem1 : nelem2)));
}

Datum
similarity(PG_FUNCTION_ARGS)
{
  text *in1 = PG_GETARG_TEXT_P(0);
  text *in2 = PG_GETARG_TEXT_P(1);
  TRGM *trg1, *trg2;
  float4 res;

  trg1 = generate_trgm(VARDATA(in1), VARSIZE(in1) - VARHDRSZ);
  trg2 = generate_trgm(VARDATA(in2), VARSIZE(in2) - VARHDRSZ);

  res = cnt_sml(trg1, trg2);

  pfree(trg1);
  pfree(trg2);
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

/**
 *Converts a q-gram to a string representation.
 * Input:
 *   Pointer to the beginning of a trgm.
 * Output:
 *   A string that looks like [c, a, t] for the trigram "cat".
 *   (This should help see whitespace or failures.)
 */
void print_qgram(trgm* t) {
  int i;
  /** 
   * Allocate memory for our return string.
   * We need 3 chars for [, ], and \0 (null char at the end), and
   * 3 char per letter in trigram, EXCEPT the last one, where we only need 1 ch
   * Therefore, 3 + 3*3 - 2 = 1+3*3.
   */

  // FIXME: Change for qgrams
  char* s = palloc (1+3*3);

  s[0] = '[';
  /* Loop through each q-gram and insert str of form "X, " into the proper place */
  // FIXME: Change for qgrams
  for (i = 0; i < 3; i ++) {
    // s+1+3*i = (base ptr) + ('[' char) + (3 chars per letter in q-gram)
    sprintf(s+1+3*i, "%c, ", *((char*)t+i));
  }
  
  // FIXME: Change for qgrams
  s[-1+3*3] = ']'; /* lol, C. I'm overwriting the last ", " with "]\0" */
  s[0 +3*3] = '\0';
  
  elog(LOG, "%s", s);
  pfree(s);
}
  
/**
 *Converts a contiguous block of qgrams to a string representation.
 * Input:
 *   Pointer to the beginning of the list of trgms.
 *   Number of trigrams in the list of trgms
 */
void print_qgram_array(trgm* trgms, int num_trgms) {
  int i;
  trgm *tmp;
  tmp = trgms;
  for(i = 0; i < num_trgms; i++) {
    print_qgram(tmp);
    // FIXME: Change for qgrams
    tmp++;
  }
}
