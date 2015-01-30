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
    cur.execute("Select Distinct Household from hes_database.appliance_group_data")
    # Retrieve them all
    HouseNumbers = cur.fetchall()

    # Tables can't be called numbers, use t+number as temporary holding name
    for row in HouseNumbers:
        tic = timeit.default_timer()
        HouseNumber1 = row["Household"]
        HouseNumber2 = 't' + HouseNumber1
        HouseNumber3 = 'n' + HouseNumber1
        mHouseNumber = 'm' + HouseNumber1
        nHouseNumber = 'n' + HouseNumber1
        pHouseNumber = 'p' + HouseNumber1

        drop_t_tables = "drop table if exists %s" %(HouseNumber2)
        drop_n_tables = "drop table if exists %s" %(HouseNumber3)
        drop_together_tables = "drop table if exists dt_%s" % (HouseNumber1)
        cur.execute(drop_t_tables)
        cur.execute(drop_n_tables)
        cur.execute(drop_together_tables)

        # create the temporary tables t+housenumber
        create_t_tables = "create table %s \
        (id mediumint not null auto_increment, IntervalID mediumint(8), HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data int, Dates Date, Hour int, Minute int,\
        primary key (id))" % (HouseNumber2)

        cur.execute(create_t_tables)

        # insert the information we need from the hes_database to our current working database, \
        # removing appliances 251-255 (They are temperature readings)
        insert_t_tables = "INSERT INTO %s \
        (IntervalID, HouseID, Appliance, Data, Dates, Hour, Minute)\
        SELECT hes.IntervalID,  hes.Household, hes.Appliance, hes.Data, date(hes.TimeInterval), extract(hour from hes.TimeInterval), \
        extract(minute from hes.TimeInterval) \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s AND Appliance NOT IN (251,252,253,245,255)"  % (HouseNumber2, HouseNumber1)

        cur.execute(insert_t_tables)

        table_dt_Id1 = "create table dt_%s_Id1 \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HouseNumber1)

        table_dt_Id2 = "create table dt_%s_Id2 \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HouseNumber1)

        table_dt_Id3 = "create table dt_%s_Id3 \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HouseNumber1)

        cur.execute(table_dt_Id1)
        cur.execute(table_dt_Id2)
        cur.execute(table_dt_Id3)

        into_dt_Id1 = "INSERT INTO dt_%s_Id1 (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data), Dates, Hour, Minute \
        FROM %s \
        WHERE IntervalID = 1 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        into_dt_Id2 = "INSERT INTO dt_%s_Id2 (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data), Dates, Hour, Minute \
        FROM %s \
        WHERE IntervalID = 2 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        into_dt_Id3 = "INSERT INTO dt_%s_Id3 (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data), Dates, Hour, Minute \
        FROM %s \
        WHERE IntervalID = 3 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        cur.execute(into_dt_Id1)
        cur.execute(into_dt_Id2)
        cur.execute(into_dt_Id3)

        """create_m_house_tables_Id1 = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Dates Date, Hour int,\
        primary key (id))" % (mHouseNumber)

        cur.execute(create_m_house_tables_Id1)

        into_m_tables_Id1 = "INSERT INTO %s (HouseID, Data, Dates, Hour) \
        SELECT HouseID, sum(Data), Date, Hour FROM dt_%s_Id1 \
        GROUP BY Date, Hour" % (mHouseNumber, HouseNumber1)

        cur.execute(into_m_tables_Id1)

        create_n_house_tables_Id2 = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Dates Date, Hour int,\
        primary key (id))" % (nHouseNumber)

        cur.execute(create_n_house_tables_Id2)

        into_n_tables_Id2 = "INSERT INTO %s (HouseID, Data, Dates, Hour) \
        SELECT HouseID, sum(Data), Date, Hour FROM dt_%s_Id2 \
        GROUP BY Date, Hour" % (nHouseNumber, HouseNumber1)

        cur.execute(into_n_tables_Id2)

        create_p_house_tables_Id3 = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Dates Date, Hour int,\
        primary key (id))" % (pHouseNumber)

        cur.execute(create_p_house_tables_Id3)

        into_p_tables_Id3 = "INSERT INTO %s (HouseID, Data, Dates, Hour) \
        SELECT HouseID, sum(Data), Date, Hour FROM dt_%s_Id3 \
        GROUP BY Date, Hour" % (pHouseNumber, HouseNumber1)

        cur.execute(into_p_tables_Id3)"""

        drop_t = "drop table %s" % (HouseNumber2)
        drop_dt= "drop table dt_%s" % (HouseNumber1)

        cur.execute(drop_t)
        #cur.execute(drop_dt)

        toc = timeit.default_timer()

        time = toc - tic
        print time



