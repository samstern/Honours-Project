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
    #cur.execute("Select Distinct Household from hes_database.appliance_group_data limit 1")
    #cur.execute("Select Distinct Household from hes_database.appliance_group_data limit 15")
    cur.execute("Select Distinct Household from hes_database.appliance_group_data")
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
        cur.execute(drop_together_tables)

        # How to extract the day of the week from the date
        Day_of_the_week = "date_format(date(hes.TimeInterval), '%W')"

        # create the temporary tables t+housenumber
        create_house_tables = "create table %s \
        (id mediumint not null auto_increment, IntervalID mediumint(8), HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data int, Dates Date, Hour int, Minute int,\
        primary key (id))" % (HouseNumber2)

        cur.execute(create_house_tables)

        # insert the information we need from the hes_database to our current working database
        insert_into_house_tables = "INSERT INTO %s \
        (IntervalID, HouseID, Appliance, Data, Dates, Hour, Minute)\
        SELECT hes.IntervalID,  hes.Household, hes.Appliance, hes.Data, date(hes.TimeInterval), extract(hour from hes.TimeInterval), \
        extract(minute from hes.TimeInterval) \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s" % (HouseNumber2, HouseNumber1)


        cur.execute(insert_into_house_tables)


        # Data_together is another temporary table, this time we insert data in watts, need for conversion
        # Interval ID's represent the measurement of the data
        # 1 = 1 Month, 2min  interval
        # 2 = 1 Year,  2min  interval
        # 3 = 1 Year,  10min interval
        # readings are in dWh (deci-Watt-Hours)
        # to convert 2 minute readings to Watts multiply by 3
        # to convert 10 minute readings to Watts multiply by 0.6
        table_data_together = "create table data_together_%s \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HouseNumber1)

        cur.execute(table_data_together)

        into_data_together_id1 = "INSERT INTO data_together_%s (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data)*3.0, Dates, Hour, Minute \
        FROM %s \
        Where IntervalID = 1 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        into_data_together_id2 = "INSERT INTO data_together_%s (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data)*3.0, Dates, Hour, Minute \
        FROM %s \
        Where IntervalID = 2 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        into_data_together_id3 = "INSERT INTO data_together_%s (HouseID, Data, Date, Hour, Minute) \
        Select HouseID, sum(Data)*0.6, Dates, Hour, Minute \
        FROM %s \
        Where IntervalID = 3 \
        Group By Dates,Hour,Minute" % (HouseNumber1, HouseNumber2)

        cur.execute(into_data_together_id1)
        cur.execute(into_data_together_id2)
        cur.execute(into_data_together_id3)

        create_n_house_tables = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Dates Date, Hour int,\
        primary key (id))" % (HouseNumber3)

        cur.execute(create_n_house_tables)

        into_n_tables = "INSERT INTO %s (HouseID, Data, Dates, Hour) \
        SELECT HouseID, sum(Data), Date, Hour FROM data_together_%s \
        GROUP BY Date, Hour" % (HouseNumber3, HouseNumber1)

        cur.execute(into_n_tables)

        drop_t = "drop table %s" % (HouseNumber2)
        drop_dt= "drop table data_together_%s" % (HouseNumber1)

        cur.execute(drop_t)
        cur.execute(drop_dt)

        toc = timeit.default_timer()

        time = toc - tic
        print time



