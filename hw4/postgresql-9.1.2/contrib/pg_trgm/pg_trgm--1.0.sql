/* contrib/pg_trgm/pg_trgm--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_trgm" to load this file. \quit

CREATE FUNCTION set_limit(float4)
RETURNS float4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT VOLATILE;

CREATE FUNCTION show_limit()
RETURNS float4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT STABLE;

CREATE FUNCTION show_trgm(text)
RETURNS _text
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION similarity(text,text)
RETURNS float4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE FUNCTION similarity_op(text,text)
RETURNS bool
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT STABLE;  -- stable because depends on trgm_limit

CREATE OPERATOR % (
        LEFTARG = text,
        RIGHTARG = text,
        PROCEDURE = similarity_op,
        COMMUTATOR = '%',
        RESTRICT = contsel,
        JOIN = contjoinsel
);

CREATE FUNCTION similarity_dist(text,text)
RETURNS float4
AS 'MODULE_PATHNAME'
LANGUAGE C STRICT IMMUTABLE;

CREATE OPERATOR <-> (
        LEFTARG = text,
        RIGHTARG = text,
        PROCEDURE = similarity_dist,
        COMMUTATOR = '<->'
);
