#!/usr/bin/python

import MySQLdb as mdb
import timeit

"""
This script takes data in 2 min invervals and sums it to 10 min intervals

"""


con = mdb.connect('localhost', 'root', '', 'Ten_Mins');

with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    
    #get tables with ID=1 and ID=2
    cur.execute("show tables from house_sets where tables_in_house_sets like '%Id1' or tables_in_house_sets like '%Id2'")

    tables = cur.fetchall()

    
    #Tables can't be called numbers, use c+number as temporary holding name    
    for table in tables:
        TableNumber = table["Tables_in_house_sets"]

        drop_tables = "drop table if exists %s" %(TableNumber)
        cur.execute(drop_tables)

        create_table = "CREATE TABLE %s \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))"%(TableNumber)
    
        cur.execute(create_table)

        populate_table = "INSERT INTO %s (HouseID, Data, Date, Hour, Minute) \
        (SELECT HouseID, SUM(Data), Date, Hour, Minute \
        FROM House_Sets.%s \
        GROUP BY Date, Hour, FLOOR(Minute/10))" %(TableNumber,TableNumber)

        cur.execute(populate_table)



    cur.execute("show tables from house_sets where tables_in_house_sets like '%Id3'")

    tables = cur.fetchall()

    for table in tables:
        TableNumber = table["Tables_in_house_sets"]

        drop_tables = "drop table if exists %s" %(TableNumber)
        cur.execute(drop_tables)

        create_table = "CREATE TABLE %s like House_Sets.%s" %(TableNumber,TableNumber)

        cur.execute(create_table)

        populate_table = "INSERT INTO %s SELECT * FROM House_Sets.%s" %(TableNumber,TableNumber)

        cur.execute(populate_table)







        



    
    
