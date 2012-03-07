/* contrib/pg_trgm/pg_trgm--unpackaged--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_trgm" to load this file. \quit

ALTER EXTENSION pg_trgm ADD function set_limit(real);
ALTER EXTENSION pg_trgm ADD function show_limit();
ALTER EXTENSION pg_trgm ADD function show_trgm(text);
ALTER EXTENSION pg_trgm ADD function similarity(text,text);
ALTER EXTENSION pg_trgm ADD function similarity_op(text,text);
ALTER EXTENSION pg_trgm ADD operator %(text,text);

-- These were not in 9.0:

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

