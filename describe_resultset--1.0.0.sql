/* describe_resultset--1.0.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION describe_resultset" to load this file. \quit

CREATE TYPE describe_resultset_data AS
(
    column_name     name,
    column_type     oid,
    column_len      INT,
    column_attrs    TEXT
);

CREATE FUNCTION describe_resultset_internal(cmd TEXT)
RETURNS SETOF describe_resultset_data
AS 'MODULE_PATHNAME','describe_resultset'
LANGUAGE C STABLE STRICT;

CREATE FUNCTION describe_resultset(cmd TEXT)
RETURNS TABLE (
    column_name     	name,
    column_type     	oid,
    column_type_name 	name,
    column_len      	INT,
    column_attrs    	TEXT
)
LANGUAGE SQL STABLE STRICT
AS $$ 
SELECT 
    f.column_name  
    ,f.column_type  
    ,pgt.typname
    ,f.column_len   
    ,f.column_attrs 
FROM
    describe_resultset_internal(cmd) f
INNER JOIN
    pg_type pgt
ON pgt.oid = f.column_type;
$$;