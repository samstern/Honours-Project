#!/usr/bin/python

import MySQLdb as mdb
import timeit

"""
This script takes data in 2 min invervals and sums it to 10 min intervals

TODO for real (not test set)
- change con from Ten_Mins_Subset to Ten_Mins
- check in information_schema.tables that you have deleted the dables from the test households (or renamed them)
- remove subset from create_table and populate_table for both Id1/2 and Id3

"""


con = mdb.connect('localhost', 'root', '', 'Ten_Mins_Subset');

with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    
    #get tables with ID=1 and ID=2
    cur.execute("select table_name from information_schema.tables where table_name like '%Id1' or table_name like '%Id2'")

    tables = cur.fetchall()

    
    #Tables can't be called numbers, use c+number as temporary holding name    
    for table in tables:
        TableNumber = table["table_name"]

        drop_tables = "drop table if exists %s" %(TableNumber)
        cur.execute(drop_tables)

        create_table = "CREATE TABLE %s \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))"%(TableNumber)
    
        cur.execute(create_table)

        populate_table = "INSERT INTO %s (HouseID, Data, Date, Hour, Minute) \
        (SELECT HouseID, SUM(Data), Date, Hour, Minute \
        FROM House_Sets_Subset.%s \
        GROUP BY Date, Hour, FLOOR(Minute/10))" %(TableNumber,TableNumber)

        cur.execute(populate_table)



    cur.execute("select table_name from information_schema.tables where table_name like '%Id3'")

    tables = cur.fetchall()

    for table in tables:
        TableNumber = table["table_name"]

        drop_tables = "drop table if exists %s" %(TableNumber)
        cur.execute(drop_tables)

        create_table = "CREATE TABLE %s like House_Sets_Subset.%s" %(TableNumber,TableNumber)

        cur.execute(create_table)

        populate_table = "INSERT INTO %s SELECT * FROM House_Sets_Subset.%s" %(TableNumber,TableNumber)

        cur.execute(populate_table)







        



    
    
