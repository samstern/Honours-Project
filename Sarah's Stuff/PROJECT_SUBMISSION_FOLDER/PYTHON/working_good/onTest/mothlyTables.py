#!/usr/bin/python

import MySQLdb as mdb
import timeit


con = mdb.connect('localhost', 'root', '', 'split');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    # Get the household ID numbers
    cur.execute("Select Distinct Household from hes_database.appliance_group_data where IntervalID = 1")
    # Retrieve them all
    HouseNumbers = cur.fetchall()

    # Tables can't be called numbers, use t+number as temporary holding name
    for row in HouseNumbers:
        tic = timeit.default_timer()
        HouseNumber1 = row["Household"]
        HouseNumber2 = 't' + HouseNumber1

        drop_t_tables = "drop table if exists %s" %(HouseNumber2)
        cur.execute(drop_t_tables)

        # create the temporary tables t+housenumber
        create_t_tables = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data int, Dates Date, Hour int, Minute int,\
        primary key (id))" % (HouseNumber2)

        cur.execute(create_t_tables)

        # insert the information we need from the hes_database to our current working database, \
        # removing appliances 251-255 (They are temperature readings)
        insert_t_tables = "INSERT INTO %s \
        (HouseID, Appliance, Data, Dates, Hour, Minute)\
        SELECT hes.Household, hes.Appliance, hes.Data, date(hes.TimeInterval), extract(hour from hes.TimeInterval), \
        extract(minute from hes.TimeInterval) \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s AND Appliance NOT IN (251,252,253,245,255)"  % (HouseNumber2, HouseNumber1)

        cur.execute(insert_t_tables)



        table_dt_mon = "create table %s_00 \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HouseNumber1)


        cur.execute(table_dt_mon)

        into_dt_mon = "INSERT INTO %s_00 (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data), Dates, Hour, Minute \
        FROM %s \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)


        cur.execute(into_dt_mon)


        drop_t = "drop table %s" % (HouseNumber2)
        drop_dt= "drop table dt_%s" % (HouseNumber1)

        cur.execute(drop_t)
        #cur.execute(drop_dt)

        toc = timeit.default_timer()

        time = toc - tic
        print time




