#ifndef SIMJOINUTIL_H
#define SIMJOINUTIL_H
#include "postgres.h"
#include "utils/trgm.h"
#include "access/htup.h"

/**
 * Utility functions related to the inverted index.
 * DO NOT MODIFY THIS FILE - we reserve the right to change implementation details at any time.
 */

/******************* INDEX ACCESSORS *******************/
/*
 * Auxiliary functions to help accessing the fields of InvertedIndexEntries when given
 * a raw SimIndexEntryId into the inverted index (analagous to an index into an array).
 * These require the variable "invertedIndex" to be present and thusly named.
 */
/* Gets the InvertedIndexEntry* associated with a particular IndexEntryId. You shouldn't need to use this. */
#define GET_ENTRY(entryId)  ( invertedIndex->entries[entryId] )

/* Gets the trigram associated with a particular SimIndexEntryId. */
#define GET_TRGM(entryId)   ( entryId >= 0 ? GET_ENTRY(entryId)->trgm                : NULL )
/* Gets the MinimalTuple associated with a particular SimIndexEntryId. */
#define GET_TUP(entryId)    ( entryId >= 0 ? GET_ENTRY(entryId)->wMinTuple->minTuple : NULL )
/* Gets the number of trigrams in the MinimalTuple associated with a particular SimIndexEntryId. */
#define GET_NTRGMS(entryId) ( entryId >= 0 ? GET_ENTRY(entryId)->wMinTuple->numTrgms : -1 )

/******************* INDEX STRUCTURES *******************/
/* A MinimalTuple wrapped with auxiliary info for the similarity join! */
typedef struct {
  int          numTrgms;
  MinimalTuple minTuple;
} WrappedMinimalTuple;

/* A single Index Entry -- conceptually, a (trgm ; tuple) pair. */
typedef struct {
  trgm                *trgm;
  WrappedMinimalTuple *wMinTuple;
} SimIndexEntry;

/* The entire InvertedIndex object. */
typedef struct {
  SimIndexEntry **entries;
  int             numEntries;
  bool            finalized;
} SimInvertedIndex;

/******************* PAY ATTENTION TO THIS *******************/
/** The Id of a SimIndexEntry -- use this Id to look up particular Entries in the index. */
typedef int SimIndexEntryId;

/* The 'null' IndexEntryId. Be careful not to just use 'NULL' -- that refers to Id 0! */
#define NULL_ENTRY_ID ( (SimIndexEntryId) -1 )


/******************* In-Memory Inverted Index functions  *******************/
/** Creates a new SimInvertedIndex. The parameter is unused -- just provide NULL. */
SimInvertedIndex* CreateSimInvertedIndex(void *nothing);

/** Stores a new SimIndexEntry in the given Inverted Index. */
void ExecStoreSimIndexEntry( SimInvertedIndex *invertedIndex,
			     trgm *t,
			     MinimalTuple minTuple,
			     int numTrgms );
/*
 * Finalizes the index. You must call this after inserting all entries.
 * This will ensure that all records are in sorted order within each l_t.
 */
void ExecFinalizeSimInvertedIndex(SimInvertedIndex *invertedIndex);

/* 
 * Returns the Id for the FIRST IndexEntry that contains this trigram. 
 * (In other words, it's the first element of l_t from the spec.)
 * If the trigram is not found in the index, NULL_ENTRY_ID will be returned.
 */
SimIndexEntryId ExecGetFirstEntryIdForTrigram(SimInvertedIndex *invertedIndex,
					      trgm *t);

/*
 * Returns the next Id in the list of IndexEntries for this trigram.
 * Returns NULL_ENTRY_ID if there are no more IndexEntries (tuples) that contain 
 * the current trigram.
 */
SimIndexEntryId ExecGetNextEntryId(SimInvertedIndex *invertedIndex,
				   SimIndexEntryId currentEntryId);

int cmpIndex(const void *a, const void *b);
int cmptup(MinimalTuple a, MinimalTuple b);
#endif
