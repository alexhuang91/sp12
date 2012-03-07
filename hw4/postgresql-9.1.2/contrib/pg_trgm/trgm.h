/*
 * contrib/pg_trgm/trgm.h
 */
#ifndef __TRGM_H__
#define __TRGM_H__

#include "access/gist.h"
#include "access/itup.h"
#include "storage/bufpage.h"
#include "utils/builtins.h"

/* options */
#define LPADDING 2
#define RPADDING 1
#define KEEPONLYALNUM
/*
 * Caution: IGNORECASE macro means that trigrams are case-insensitive.
 * If this macro is disabled, the ~~* operator must be removed from the
 * operator classes, because we can't handle case-insensitive wildcard search
 * with case-sensitive trigrams.  Failure to do this will result in "cannot
 * handle ~~* with case-sensitive trigrams" errors.
 */
#define IGNORECASE
#define DIVUNION

/* operator strategy numbers */
#define SimilarityStrategyNumber 1
#define DistanceStrategyNumber 2
#define LikeStrategyNumber 3
#define ILikeStrategyNumber 4

// FIXME - the size of a qgrm is determined at runtime now. Not statically.
typedef char trgm[3];

/* This gets the value of q set by the environment variable POSTGRES_Q_GRAM at runtime */
#define q_str getenv("POSTGRES_Q_GRAM")
#define q ((q_str == NULL || q_str[0] == '\0') ? 3 : atoi(q_str))
#define size_of_trgm // FIXME: write a macro for size_of_trgm that works for your trgm representation!

#ifdef KEEPONLYALNUM
#define ISPRINTABLECHAR(a) ( isascii( *(unsigned char*)(a) ) && (isalnum( *(unsigned char*)(a) ) || *(unsigned char*)(a)==' ') )
#else
#define ISPRINTABLECHAR(a) ( isascii( *(unsigned char*)(a) ) && isprint( *(unsigned char*)(a) ) )
#endif
#define ISPRINTABLETRGM(t) ( ISPRINTABLECHAR( ((char*)(t)) ) && ISPRINTABLECHAR( ((char*)(t))+1 ) && ISPRINTABLECHAR( ((char*)(t))+2 ) )

#define ISESCAPECHAR(x) (*(x) == '\\') /* Wildcard escape character */

typedef struct
{
  int32 vl_len_; /* varlena header (do not touch directly!) */
  uint8 flag;
  char data[1];
} TRGM;

#define TRGMHDRSIZE  (VARHDRSZ + sizeof(uint8))

/* gist */
#define BITBYTE 8
#define SIGLENINT 3 /* >122 => key will toast, so very slow!!! */
#define SIGLEN (sizeof(int)*SIGLENINT)

#define SIGLENBIT (SIGLEN*BITBYTE - 1) /* see makesign */

typedef char BITVEC[SIGLEN];
typedef char *BITVECP;

#define LOOPBYTE  \
  for(i=0;i<SIGLEN;i++)

#define GETBYTE(x,i) ( *( (BITVECP)(x) + (int)( (i) / BITBYTE ) ) )
#define GETBITBYTE(x,i) ( (((char)(x)) >> (i)) & 0x01 )
#define CLRBIT(x,i)   GETBYTE(x,i) &= ~( 0x01 << ( (i) % BITBYTE ) )
#define SETBIT(x,i)   GETBYTE(x,i) |=  ( 0x01 << ( (i) % BITBYTE ) )
#define GETBIT(x,i) ( (GETBYTE(x,i) >> ( (i) % BITBYTE )) & 0x01 )

#define HASHVAL(val) (((unsigned int)(val)) % SIGLENBIT)
#define HASH(sign, val) SETBIT((sign), HASHVAL(val))

#define ARRKEY 0x01
#define SIGNKEY 0x02
#define ALLISTRUE 0x04

#define ISARRKEY(x) ( ((TRGM*)x)->flag & ARRKEY )
#define ISSIGNKEY(x) ( ((TRGM*)x)->flag & SIGNKEY )
#define ISALLTRUE(x) ( ((TRGM*)x)->flag & ALLISTRUE )

// FIXME - sizeof(trgm) will have to be replaced by size_of_trgm. Why?
#define SCOOT_TRIGRAM_RIGHT(ptr) ( ptr = (trgm *) ((char*)ptr + sizeof(trgm)) )
#define RANGE_IN_BYTES(bot,top)  ((char *)top - (char*)bot)

// FIXME - sizeof(trgm) will have to be replaced by size_of_trgm. Why?
#define CALCGTSIZE(flag, len) ( TRGMHDRSIZE + ( ( (flag) & ARRKEY ) ? ((len)*sizeof(trgm)) : (((flag) & ALLISTRUE) ? 0 : SIGLEN) ) )
#define GETSIGN(x) ( (BITVECP)( (char*)x+TRGMHDRSIZE ) )
#define GETARR(x) ( (trgm*)( (char*)x+TRGMHDRSIZE ) )
// FIXME - sizeof(trgm) will have to be replaced by size_of_trgm. Why?
#define ARRNELEM(x) ( ( VARSIZE(x) - TRGMHDRSIZE )/sizeof(trgm) )

extern float4 trgm_limit;

TRGM *generate_trgm(char *str, int slen);
float4 cnt_sml(TRGM *trg1, TRGM *trg2);

int cmpchar(char a, char b);
int cmppchar(trgm *a, trgm *b, int i);
int cmptrgm(trgm *a, trgm *b);
void cptrgm(trgm *a, trgm *b);

void print_qgram(trgm *a);
void print_qgram_array(trgm *a, int num_trgms);
#endif   /* __TRGM_H__ */
