#!/usr/bin/python

import MySQLdb as mdb
from types import NoneType

con = mdb.connect('localhost', 'root', '', 'test');
first_half_of_the_hour = range(0,30)
second_half_of_the_hour = range(30,60)
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
        HouseNumber2 = 't' + HouseNumber1
        HouseNumber3 = 'n' + HouseNumber1

        drop_tables = "drop table if exists %s" % (HouseNumber2)
        cur.execute(drop_tables)

        # How to extract the day of the week from the date
        Day_of_the_week = "date_format(date(hes.TimeInterval), '%W')"

        # create the temporary tables t+housenumber
        create_house_tables = "create table %s \
        (id mediumint not null auto_increment, IntervalID mediumint(8), HouseID varchar(8), Appliance smallint(5) unsigned,\
        Data smallint(6), Year int, Month int, Day int, Hour int,\
        DayOfTheWeek varchar(10), primary key (id))" % (HouseNumber2)

        cur.execute(create_house_tables)

        # insert the informtaion we need from the hes_database to our current working database
        insert_into_house_tables = "INSERT INTO %s \
        (IntervalID, HouseID, Appliance,Data,Year, Month, Day, Hour, DayOfTheWeek)\
        SELECT hes.IntervalID,  hes.Household, hes.Appliance, hes.Data, YEAR(hes.TimeInterval), \
        MONTH(hes.TimeInterval), DAY(hes.TimeInterval), extract(hour from hes.TimeInterval), %s \
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
        Data int, Year int, Month int, Day int, Hour int, DayOfTheWeek varchar(10), \
        primary key (Id))" % (HouseNumber1)

        cur.execute(table_data_together)

        # List of all different times that occur together
        distincts = "create view Distincts as \
        select Year, Month, Day, Hour from %s" % (HouseNumber2)
        cur.execute(distincts)
        cur.execute("select * from Distincts ORDER BY Year, Month, Day, Hour limit 100")

        dist = cur.fetchall()

        # extract a year etc from each line you get
        # for each line take all appliances that have readings at these times and then put them together into one temp dbs to sum up these values
        for line in dist:
            yr = line["Year"]
            mth = line["Month"]
            dy = line["Day"]
            hr = line["Hour"]

            cur.execute("drop table if exists temp_id1")
            cur.execute("drop table if exists temp_id2")
            cur.execute("drop table if exists temp_id3")

            # Interval ID's represent the measurement of the data
            # 1 = 1 Month, 2min  interval
            # 2 = 1 Year,  2min  interval
            # 3 = 1 Year,  10min interval
            # readings are in dWh (deci-Watt-Hours)
            # to convert 2 minute readings to Watts multiply by 3
            # to convert 10 minute readings to Watts multiply by 0.6

            # The ID is 1
            temp_table_id1 = "create table temp_id1 (id int, Data int,Appliance int)"
            cur.execute(temp_table_id1)

            into_temp_id1 = "insert into temp_id1 (id, Data, Appliance) \
            Select id, Data, Appliance from %s where Year = %s and Month = %s and  \
            Day = %s and Hour = %s and IntervalID = 1" % (HouseNumber2, yr, mth, dy, hr)
            cur.execute(into_temp_id1)

            sums1 = "select sum(Data) from temp_id1"

            cur.execute(sums1)
            total_sums1 = cur.fetchone()
            total_sums1 = total_sums1["sum(Data)"]

            if type(total_sums1) is NoneType:
                total_sums1 = 0
            else:
                total_sums1 = int(total_sums1)

                # The ID is 2
            temp_table_id2 = "create table temp_id2 (id int, Data int,Appliance int)"
            cur.execute(temp_table_id2)

            into_temp_id2 = "insert into temp_id2 (id, Data, Appliance) \
            Select id, Data, Appliance from %s where Year = %s and Month = %s and  \
            Day = %s and Hour = %s and IntervalID = 2" % (HouseNumber2, yr, mth, dy, hr)
            cur.execute(into_temp_id2)

            sums2 = "select sum(Data) from temp_id2"

            cur.execute(sums2)
            total_sums2 = cur.fetchone()
            total_sums2 = total_sums2["sum(Data)"]

            if type(total_sums2) == NoneType:
                total_sums2 = 0
            else:
                total_sums2 = int(total_sums2)


            # The ID is 3
            temp_table_id3 = "create table temp_id3 (id int, Data int,Appliance int)"

            cur.execute(temp_table_id3)

            into_temp_id3 = "insert into temp_id3 (id, Data, Appliance) \
            Select id, Data, Appliance from %s where Year = %s and Month = %s and  \
            Day = %s and Hour = %s and IntervalID = 3" % (HouseNumber2, yr, mth, dy, hr)
            cur.execute(into_temp_id3)

            sums3 = "select sum(Data) from temp_id3"
            cur.execute(sums3)
            total_sums3 = cur.fetchone()
            total_sums3 = total_sums3["sum(Data)"]

            if type(total_sums3) is NoneType:
                total_sums3 = 0
            else:
                total_sums3 = int(total_sums3)


            # total sum in Watts, (2min intervals * 3; 10min intercals * 0.6)
            total_sum = total_sums1 * (3) + total_sums2 * (3) + total_sums3 * (0.6)


            """insert_data_together = "insert into data_together_%s \
            (HouseID,Data,Year,Month,Day,Hour, DayOfTheWeek)  \
            select Distinct HouseID, (%s), Year, Month, Day, Hour, DayOfTheWeek \
            from %s where Year = %s and Month = %s and Day = %s and Hour = %s group by Hour"  \
            % (HouseNumber1, total_sum, HouseNumber2, yr, mth, dy, hr)"""

            insert_data_together = "insert into data_together_%s \
            (HouseID, Data, Year, Month, Day, Hour) \
            values  (%s, %s, %s, %s, %s, %s)" % (HouseNumber1, HouseNumber1, total_sum, yr, mth, dy, hr)

            cur.execute(insert_data_together)

            # drop temporary tables
            cur.execute("drop table if exists temp_id1")
            cur.execute("drop table if exists temp_id2")
            cur.execute("drop table if exists temp_id3")





