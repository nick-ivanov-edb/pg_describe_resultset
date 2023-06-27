EXTENSION = describe_resultset
MODULE_big = describe_resultset
PGFILEDESC = "describe_resultset - function that returns a result set descriptor"
DATA = describe_resultset--1.0.0.sql
OBJS = describe_resultset.o 
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)