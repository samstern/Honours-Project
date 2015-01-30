#!/usr/bin/python

import MySQLdb as mdb

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:

    cur = con.cursor()
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for row in all_tables:
        query = "drop table %s" % (row)
        cur.execute(query)