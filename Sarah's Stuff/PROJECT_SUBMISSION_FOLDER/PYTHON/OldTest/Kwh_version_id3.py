#!/usr/bin/python

import MySQLdb as mdb
import timeit

first_half_hour = range(0,30)
second_half_hour = range(30,60)

con = mdb.connect('localhost', 'root', '', 'test');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    # Get the household ID numbers
    cur.execute("Select Distinct Household from hes_database.appliance_group_data limit 1")
    # Retrieve them all
    HouseNumbers = cur.fetchall()

    # Tables can't be called numbers, use t+number as temporary holding name
    for row in HouseNumbers:
        tic = timeit.default_timer()
        HouseNumber1 = row["Household"]
        HouseNumber2 = 't' + HouseNumber1
        HouseNumber3 = 'n' + HouseNumber1

        drop_t_tables = "drop table if exists %s" %(HouseNumber2)
        drop_n_tables = "drop table if exists %s" %(HouseNumber3)
        drop_together_tables = "drop table if exists data_together_%s" % (HouseNumber1)
        cur.execute(drop_t_tables)
        cur.execute(drop_n_tables)


        create_t_table = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Dates Date, Hour int, Minute int,\
        primary key (id))" % (HouseNumber2)


        into_t_table = "INSERT INTO %s (HouseID, Data, Dates, Hour, Minute) \
        Select hes.Household, sum(hes.Data), Date(hes.TimeInterval), Hour(hes.TimeInterval), Minute(hes.TimeInterval) \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s AND hes.IntervalId = 3 \
        Group By Date(hes.TimeInterval),Hour(hes.TimeInterval),Minute(hes.TimeInterval)" % (HouseNumber2, HouseNumber1)

        cur.execute(create_t_table)
        cur.execute(into_t_table)

        """create_n_table = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        hrData int, hrDates Date, hrHour int,\
        primary key (id))" % (HouseNumber3)

        into_n_table = "INSERT INTO %s (HouseID, hrData, hrDates, hrHour) \
        Select HouseID, sum(Data), Dates, Hour, \
        FROM %s  \
        Group By Dates, Hour," % (HouseNumber3, HouseNumber2)"""


        #cur.execute(create_n_table)
        #cur.execute(into_n_table)

        toc = timeit.default_timer()

        time = toc - tic
        print time
