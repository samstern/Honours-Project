#!/usr/bin/python

import MySQLdb as mdb
import timeit

"""
TODO when running on full dataset
-change the first SQL query to '... from hes_database.total_profiles'
-change insert_t_tables to '... from hes_database.appliance_group_data'
-change con=... to con=mdb.connect('localhost', 'root', '', 'House_Sets); - 
"""


con = mdb.connect('localhost', 'root', '', 'House_Sets');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    # Get the household ID numbers
    cur.execute("Select Distinct Household from hes_database.total_profiles")
    # Retrieve them all
    HouseNumbers = cur.fetchall()
    count=0
    # Tables can't be called numbers, use t+number as temporary holding name
    for row in HouseNumbers:
        count +=1
        print count
        tic = timeit.default_timer()
        HouseNumber1 = row["Household"]
        HouseNumber2 = 't' + HouseNumber1

        drop_t_tables = "drop table if exists %s" %(HouseNumber2)

        drop_together_tables = "drop table if exists dt_%s" % (HouseNumber1)
        cur.execute(drop_t_tables)

        cur.execute(drop_together_tables)

        # Want to get a list of the appliances in total_profiles that add together to get a total \
        # energy use profile for households

        get_appliance_lists = "Select distinct Appliance from hes_database.total_profiles where Household = %s" %(HouseNumber1)
        cur.execute(get_appliance_lists)

        Total_Profile_Appliance_List = cur.fetchall()
        Profile_Appl_List = []
        for line in Total_Profile_Appliance_List:

            TPAL = line["Appliance"]
            Profile_Appl_List.append(TPAL)
        Appliance_List = list(set(Profile_Appl_List))

        # if you use tuple() on a list of one : (number,) <-- Creates MySQL sytax error for in tuple() error!
        if len(Appliance_List) == 1:
            Appliance_Numbers = '(' + str(Appliance_List[0]) + ')'
        else:

            Appliance_Numbers = tuple(Appliance_List)
        print Appliance_Numbers
        # create the temporary tables t+housenumber
        create_t_tables = "create table %s \
        (id mediumint not null auto_increment, IntervalID mediumint(8), HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data int, Dates Date, Hour int, Minute int,\
        primary key (id))" % (HouseNumber2)

        cur.execute(create_t_tables)

        # insert the information we need from the hes_database.total_profiles to our current working database, \
        # only using the appliances that we need to add up to make a total profile
        insert_t_tables = "INSERT INTO %s \
        (IntervalID, HouseID, Appliance, Data, Dates, Hour, Minute)\
        SELECT hes.IntervalID,  hes.Household, hes.Appliance, hes.Data, hes.Date, extract(hour from hes.TimeInterval), \
        extract(minute from hes.TimeInterval) \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s AND Appliance IN %s"  % (HouseNumber2, HouseNumber1, Appliance_Numbers)

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


        toc = timeit.default_timer()

        time = toc - tic
        print time
