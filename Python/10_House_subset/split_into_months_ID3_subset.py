#!/usr/bin/python

import MySQLdb as mdb
from functions_subset import GetInfoId3

"""
TODO (when running on full dataset)

- Change con to ...Total_Profile_Monthly
- Change to Ten_Mins for each 'insert_' statement
"""
con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly_Subset');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    tables = GetInfoId3(cur)
    for HN in tables:
        HN = str(HN)
        TN = str(HN)

        HN = HN.split('_')[5]


        TN = TN.split()
        TN = TN[2].split("'")[1]


        jan_tab = "create table %s_01 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        feb_tab = "create table %s_02 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        mar_tab = "create table %s_03 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        april_tab = "create table %s_04 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        may_tab = "create table %s_05 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        jun_tab = "create table %s_06 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        jul_tab = "create table %s_07 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        aug_tab = "create table %s_08 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        sept_tab = "create table %s_09 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        oct_tab = "create table %s_10 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        nov_tab = "create table %s_11 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        dec_tab = "create table %s_12 (ID mediumint not null auto_increment,\
        HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (HN)

        cur.execute(jan_tab)
        cur.execute(feb_tab)
        cur.execute(mar_tab)
        cur.execute(april_tab)
        cur.execute(may_tab)
        cur.execute(jun_tab)
        cur.execute(jul_tab)
        cur.execute(aug_tab)
        cur.execute(sept_tab)
        cur.execute(oct_tab)
        cur.execute(nov_tab)
        cur.execute(dec_tab)

        into_jan = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 1' % (HN,'Ten_Mins_Subset',TN)

        into_feb = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 2' % (HN,'Ten_Mins_Subset',TN)

        into_mar = 'INSERT INTO %s_03 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 3' % (HN,'Ten_Mins_Subset',TN)

        into_april = 'INSERT INTO %s_04 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 4' % (HN,'Ten_Mins_Subset',TN)

        into_may = 'INSERT INTO %s_05 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 5' % (HN,'Ten_Mins_Subset',TN)

        into_jun = 'INSERT INTO %s_06 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 6' % (HN,'Ten_Mins_Subset',TN)

        into_jul = 'INSERT INTO %s_07 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 7' % (HN,'Ten_Mins_Subset',TN)

        into_aug = 'INSERT INTO %s_08 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 8' % (HN,'Ten_Mins_Subset',TN)

        into_sept = 'INSERT INTO %s_09 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 9' % (HN,'Ten_Mins_Subset',TN)

        into_oct = 'INSERT INTO %s_10 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 10' % (HN,'Ten_Mins_Subset',TN)

        into_nov = 'INSERT INTO %s_11 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 11' % (HN,'Ten_Mins_Subset',TN)

        into_dec = 'INSERT INTO %s_12 (HouseID,Data,Date,Hour,Minute) \
        SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
        FROM %s.%s A \
        WHERE MONTH(A.Date) = 12' % (HN,'Ten_Mins_Subset',TN)

        cur.execute(into_jan)
        cur.execute(into_feb)
        cur.execute(into_mar)
        cur.execute(into_april)
        cur.execute(into_may)
        cur.execute(into_jun)
        cur.execute(into_jul)
        cur.execute(into_aug)
        cur.execute(into_sept)
        cur.execute(into_oct)
        cur.execute(into_nov)
        cur.execute(into_dec)







