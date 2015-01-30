#!/usr/bin/python

import MySQLdb as mdb
from types import NoneType

con = mdb.connect('localhost', 'root', '', 'split');
with con:

    cur = con.cursor()
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for row in all_tables:
        upperquery = "SELECT * FROM %s limit 1" % (row)
        cur.execute(upperquery)
        stuff = cur.fetchone()
        if type(stuff) is NoneType:
            print row
            query = "drop table %s" % (row)
            cur.execute(query)