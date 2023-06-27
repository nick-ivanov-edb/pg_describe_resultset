This Postgres extension implements the "describe a result set" functionality,
which, given a query or another PostgreSQL command that returns a result set,
shows a list of columns in that result set, along with their respective data
types and, possibly, other attributes.

## Prerequisites

Install the postrgresql-server and postgresql-debug packages.

Make sure that the directory of Postgres binaries is in `$PATH`.

## Building the extension

Run `make`.

## Installing the extension

Assuming the current user has sufficient privileges to copy files into the 
Postgres `SHAREDIR` and `LIBDIR`, run `make install`.

Otherwise use `sudo make PG_CONFIG=BINDIR/pg_config install`.

You can then connect to the database and create the extension:

```sql
CREATE EXTENSION describe_resultset;
```

## Usage

After installing the extension, call the `describe_resultset` function:

```
SELECT * FROM describe_resultset('select 1 as foo, 1.1 as bar')
```
which will produce the following output:
```
 column_name | column_type | column_type_name | column_len | column_attrs
-------------+-------------+------------------+------------+--------------
 foo         |          23 | int4             |          4 |
 bar         |        1700 | numeric          |         -1 |
(2 rows)
```