/*-------------------------------------------------------------------------
 *
 * nodeSimjoin.h
 *
 *
 * Kitties are so cute, man. (c) Aaron Davidson.
 * Portions Copyright (c) 1996-2011, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/executor/nodeSimjoin.h
 *
 *-------------------------------------------------------------------------
 */
#ifndef NODESIMLOOP_H
#define NODESIMLOOP_H

#include "nodes/execnodes.h"

extern SimJoinState *ExecInitSimJoin(SimJoinState *node, EState *estate);
extern TupleTableSlot *ExecSimJoin(SimJoinState *node);
extern void ExecEndSimJoin(SimJoinState *node);
extern void ExecReScanSimJoin(SimJoinState *node);

#endif   /* NODENESTLOOP_H */
