#!/usr/bin/python

import MySQLdb as mdb

con = mdb.connect('localhost', 'root', '', 'test');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)

    cur.execute("drop table if exists temp")
    cur.execute("drop view if exists distincts")
    # Get the household ID numbers
    cur.execute("Select Distinct Household from hes_database.appliance_group_data limit 1")

    # Retrive them all
    HouseNumbers = cur.fetchall()

    # Tables can't be called numbers, use t+number as temperary holding name
    for row in HouseNumbers:
        HouseNumber1 = row["Household"]
        HouseNumber2 =  't' + HouseNumber1
        HouseNumber3 = 'n' + HouseNumber1

        drop_tables = "drop table if exists %s" %(HouseNumber2)
        cur.execute(drop_tables)

        # How to extract the day of the week from the date
        Day_of_the_week = "date_format(date(hes.TimeInterval), '%W')"

        # create the temporary tables t+housenumber
        create_house_tables = "create table %s \
        (id mediumint not null auto_increment, HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data smallint(6), Year int, Month int, Day int, Hour int, Minute int,\
        DayOfTheWeek varchar(10), primary key (id))" % (HouseNumber2)

        cur.execute(create_house_tables)

        # insert the informtaion we need from the hes_database to our current working database
        insert_into_house_tables = "INSERT INTO %s \
        (HouseID, Appliance,Data,Year, Month, Day, Hour, Minute, DayOfTheWeek)\
        SELECT hes.Household, hes.Appliance, hes.Data, YEAR(hes.TimeInterval), \
        MONTH(hes.TimeInterval), DAY(hes.TimeInterval), extract(hour from hes.TimeInterval), \
        extract(minute from hes.TimeInterval), %s \
        FROM hes_database.appliance_group_data hes \
        WHERE hes.Household = %s" % (HouseNumber2, Day_of_the_week, HouseNumber1)


        cur.execute(insert_into_house_tables)

        # need to remove appliances 251-255, they are temperature measures.
        temperature_removal = "delete from %s\
        where Appliance = 251 OR Appliance = 252 OR Appliance = 253 \
        OR Appliance = 254 OR Appliance = 255" % (HouseNumber2)

        cur.execute(temperature_removal)



        # create table of Year, Month, Day, Hour, Minute from t+houseNumber
        table_data_together = "create table data_together_%s \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Year int, Month int, Day int, Hour int, Minute int, DayOfTheWeek varchar(10), \
        primary key (Id))" % (HouseNumber1)

        cur.execute(table_data_together)

        # List of all different times that occur together
        distincts = "create view Distincts as \
        select Year, Month, Day, Hour, Minute from %s" % (HouseNumber2)
        cur.execute(distincts)
        cur.execute("select * from Distincts limit 10")

        dist = cur.fetchall()

        # extract a year etc from each line you get
        # for each line take all appliances that have readings at these times and then put them together into one temp dbs to sum up these values
        for line in dist:
            yr = line["Year"]
            mth = line["Month"]
            dy = line["Day"]
            hr = line["Hour"]
            mins = line["Minute"]

            temp_table = "create table temp (id int, Data int,Appliance int)"
            cur.execute(temp_table)

            into_temp = "insert into temp (id, Data, Appliance) \
            Select id, Data, Appliance from %s where Year = %s and Month = %s and \
            Day = %s and Hour = %s and Minute = %s" % (HouseNumber2, yr, mth, dy, hr, mins)
            cur.execute(into_temp)

            sums = "select sum(Data) from temp"

            insert_data_together = "insert into data_together_%s \
            (HouseID,Data,Year,Month,Day,Hour,Minute,DayOfTheWeek)  \
            select Distinct HouseID, (%s), Year, Month, Day, Hour, Minute, DayOfTheWeek \
            from %s where Year = %s and Month = %s and Day = %s and Hour = %s and Minute = %s" \
            % (HouseNumber1, sums, HouseNumber2, yr, mth, dy, hr, mins)

            cur.execute(insert_data_together)

            # drop temp
            cur.execute("drop table temp")






