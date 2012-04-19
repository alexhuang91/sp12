#include "postgres.h"

#include "utils/trgm.h"
#include "executor/execdebug.h"
#include "nodes/execnodes.h"
#include "executor/simjoinUtil.h"
#include "optimizer/var.h"
#include "utils/memutils.h"

/**
 * The functions which manage your inverted index.
 * DO NOT MODIFY THIS FILE - we reserve the right to make changes to it at any time to change implementation details.
 */

/** Creates a new SimInvertedIndex. We have a void* parameter in case we need it later -- just pass in NULL for now. */
SimInvertedIndex* CreateSimInvertedIndex(void *nothing) {
  SimIndexEntry **entries = (SimIndexEntry**) palloc0(sizeof(SimIndexEntry*)*50000); // TODO(aaron): Do something smarter here.
  SimInvertedIndex *index = (SimInvertedIndex*) palloc0(sizeof(SimInvertedIndex));
  index->entries = entries;
  index->numEntries = 0;
  index->finalized = false;
  return index;
}

/** Stores a new SimIndexEntry in the given Inverted Index. */
void ExecStoreSimIndexEntry( SimInvertedIndex *invertedIndex,
			     trgm *t,
			     MinimalTuple minTuple,
			     int numTrgms ) {
  SimIndexEntry *entry = (SimIndexEntry*) palloc(sizeof(SimIndexEntry));
  WrappedMinimalTuple *wrappedMinTup = (WrappedMinimalTuple*) palloc(sizeof(WrappedMinimalTuple));
  wrappedMinTup->numTrgms = numTrgms;
  wrappedMinTup->minTuple = minTuple;
  entry->wMinTuple = wrappedMinTup;
  entry->trgm = t;
  invertedIndex->entries[invertedIndex->numEntries] = entry;
  invertedIndex->numEntries ++;
}

/*
 * Finalizes the index. You must call this after inserting all entries.
 * This will ensure that all records are in sorted order within each l_t.
 */
void ExecFinalizeSimInvertedIndex(SimInvertedIndex *invertedIndex) {
  /** Sort the inverted index's entries. */
  qsort( (void*) invertedIndex->entries,
	 invertedIndex->numEntries,
	 sizeof(SimIndexEntry*),
	 cmpIndex );
  invertedIndex->finalized = true;
}

/* 
 * Returns the Id for the FIRST IndexEntry that contains this trigram. 
 * (In other words, it's the first element of l_t from the spec.)
 * If the trigram is not found in the index, NULL_ENTRY_ID will be returned.
 */
SimIndexEntryId ExecGetFirstEntryIdForTrigram(SimInvertedIndex *invertedIndex,
					      trgm *t) {
  if (!invertedIndex->finalized) {
    elog(ERROR, "The inverted index has not been finalized! Please call ExecFinalizeSimInvertedIndex before calling Get functions.");
  }

  SimIndexEntryId j;
  int imin = 0;
  int imax = invertedIndex->numEntries-1;

  // BINARY SEARCH BY WIKIPEDIA BECAUSE I'M LAZY AND DON'T WANT TO DEBUG MY OWN LESS PRETTY CODE
  // continue searching while [imin,imax] is not empty
  while (imax >= imin) {
    // calculate the midpoint for roughly equal partition
    int imid = (imin + imax) / 2;
    int cmp = CMPTRGM(GET_TRGM(imid), t);
    
    // determine which subarray to search
    if      (cmp <  0)
      // change min index to search upper subarray
      imin = imid + 1;
    else if (cmp > 0 )
      // change max index to search lower subarray
      imax = imid - 1;
    else {
      // Scan backwards to find the start
      for (; imid >= 0; imid--) {
	if (CMPTRGM(t, GET_TRGM(imid)) != 0) {
	  return imid+1;
	}
      }
      return 0;
    }
  }
  // key not found
  return NULL_ENTRY_ID;
}

/*
 * Returns the next Id in the list of IndexEntries for this trigram.
 * Returns NULL_ENTRY_ID if there are no more IndexEntries (tuples) that contain 
 * the current trigram.
 */
SimIndexEntryId ExecGetNextEntryId(SimInvertedIndex *invertedIndex,
				   SimIndexEntryId currentEntryId) {
  if (!invertedIndex->finalized) {
    elog(ERROR, "The inverted index has not been finalized! Please call ExecFinalizeSimInvertedIndex before calling Get functions.");
  }

  SimIndexEntryId nextEntryId = currentEntryId + 1; // that's right, it's that easy.
  // We just need to make sure the new id is associated with an IndexEntry for the
  // same trigram.
  if (currentEntryId + 1 < invertedIndex->numEntries  // make sure we're still in bounds
      && 0 == CMPTRGM(GET_TRGM(currentEntryId), GET_TRGM(nextEntryId))) {
    // We know that nextEntryId's trigram is the same as the original one -- good to go!
    return nextEntryId;
  } else {
    // This trigram has no more associated inner tuples
    return NULL_ENTRY_ID;
  }
}

int cmptup(MinimalTuple a, MinimalTuple b) {
  uint64 x = (uint64)a - (uint64)b;
  if (x == 0) {
    return 0;
  } else if ((int64)x < 0) {
    return -1;
  } else {
    return 1;
  }
}

int cmpIndex(const void *a, const void *b) {
  SimIndexEntry *entryA = *(SimIndexEntry**) a;
  SimIndexEntry *entryB = *(SimIndexEntry**) b;
  trgm *trgmA  = entryA->trgm;
  MinimalTuple mintupA = entryA->wMinTuple->minTuple;
  trgm *trgmB  = entryB->trgm;
  MinimalTuple mintupB = entryB->wMinTuple->minTuple;

  int cmp = CMPTRGM(trgmA, trgmB);
  if (cmp != 0) {
    return cmp;
  }
  return cmptup(mintupA, mintupB);
}
