/*-------------------------------------------------------------------------
 *
 * nodeSimjoin.c
 *	  routines to support nest-loop joins
 *
 * Bunnies are really quite harmless. (c) Aaron Davidson
 * Portions Copyright (c) 1996-2011, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 *
 *-------------------------------------------------------------------------
 */
#include "executor/simjoinUtil.h"
#include "utils/trgm.h"
#include "executor/execdebug.h"
#include "executor/nodeSimjoin.h"
#include "executor/nodeNestloop.h"
#include "optimizer/var.h"
#include "utils/memutils.h"
#include "utils/syscache.h"
#include "utils/lsyscache.h"
#include "catalog/namespace.h"

/*
 * Similarity threshold: [0, 1).
 * Your code should accept any (inner ; outer) tuple pairs that have
 * a trigram similarity strictly > THRESH.
 */
#define THRESH trgm_limit

/*
 * Use this to repopulate the innerTupleSlot with the given MinimalTuple.
 * This is great to call before returning the result, because ExecProject
 * requires that both the econtext->outerTupleSlot and econtext->innerTupleSlot
 * be present and correct.
 */
#define ReconstructInnerTupleSlot(innerTupleSlot, minTuple)		\
  ( innerTupleSlot = ExecStoreMinimalTuple(minTuple, node->nullInnerTupleSlot, false) )

/* Get the join column's string value (see more doc at function definition) */
char* GetSimJoinColumn(SimJoinState *node, TupleTableSlot *slot, bool isInner);

/* ----------------------------------------------------------------
 *		ExecSimJoin(node)
 * ----------------------------------------------------------------
 */
TupleTableSlot *
ExecSimJoin(SimJoinState *node)
{
	/*
	 * CS186: Mostly copied from nodeNestloop.c -- you may not need all of the following.
	 * Removing things, however, is not recommended unless you know what you're doing :D
	 */
	NestLoop   *nl;
	PlanState  *outerPlan;
	TupleTableSlot *outerTupleSlot;
	List	   *joinqual;
	List	   *otherqual;
	ExprContext *econtext;
	ListCell   *lc;
	SimInvertedIndex *invertedIndex;

	nl = (NestLoop *) node->js.ps.plan;
	joinqual = node->js.joinqual;
	otherqual = node->js.ps.qual;
	outerPlan = outerPlanState(node);
	econtext = node->js.ps.ps_ExprContext;
	invertedIndex = node->invertedIndex;

	/* YOUR CODE HERE */
	elog(NOTICE, "Hey, did you know NOTICEs show up in psql directly?");
	elog(ERROR, "I bet you didn't.");
	return NULL;
}

/* ----------------------------------------------------------------
 *		ExecInitSimJoin
 * ----------------------------------------------------------------
 */
SimJoinState *
ExecInitSimJoin(SimJoinState *node, EState *estate)
{
        /*
	 * CS186: Variables you'll probably want. You may not need all of them.
	 * Again, removing variables is not recommended.
	 */
	TupleTableSlot *innerTupleSlot;
	ExprContext *econtext = node->js.ps.ps_ExprContext;
	PlanState *innerPlan = innerPlanState(node);
	SimInvertedIndex *invertedIndex = CreateSimInvertedIndex(NULL);
	node->invertedIndex = invertedIndex;

	/* YOUR CODE HERE */
	elog(NOTICE, "Current similarity threshold: %.4f", THRESH);
	elog(ERROR, "Whoa, there, nelly. ExecInitSimJoin ain't be implemented yet!");


	/* CS186: Return the node at the end. DO NOT MODIFY OR THE WORLD WILL EXPLODE!!!! */
	return node;
}

/* ----------------------------------------------------------------
 *		ExecEndSimJoin
 * ----------------------------------------------------------------
 */
void
ExecEndSimJoin(SimJoinState *node)
{
  // not called, don't worry about this
}

/* ----------------------------------------------------------------
 *		ExecReScanSimJoin
 * ----------------------------------------------------------------
 */
void
ExecReScanSimJoin(SimJoinState *node)
{
  // not called, don't worry about this
}

/*
 * Returns the value of the join column in the given TupleTableSlot.
 * (E.g., if you're joining on "name % address", this will return the
 *  actual string value of the name for the outer tuple and address for the inner.)
 *
 * We're assuming you're joining on two strings.
 * Use isInner to specify if the given slot contains an inner tuple or outer tuple.
 */
char* GetSimJoinColumn(SimJoinState *node, TupleTableSlot *slot, bool isInner) {
  bool isnull;
  int attno = (isInner ? node->inner_attno : node->outer_attno);

  return (char*) DatumGetCString(
	 DirectFunctionCall1(textout, slot_getattr(slot, attno, &isnull)));
}
