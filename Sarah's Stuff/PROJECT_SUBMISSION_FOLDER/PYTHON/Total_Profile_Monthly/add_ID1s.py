#!/usr/bin/python

import MySQLdb as mdb
from functions import GetInfoId1, GetInfoId3


con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    IDs = GetInfoId1(cur)
    for HN in IDs:
        HN = str(HN)
        TN = str(HN)
        HN = HN.split('_')[4]


        TN = TN.split()
        TN = TN[2].split("'")[1]

        q = "drop table if exists %s_00" % (HN)
        cur.execute(q)



        table_dt_mon = "create table %s_00 \
        (Id mediumint not null auto_increment, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int, \
        primary key (Id))" % (HN)


        cur.execute(table_dt_mon)

        into_dt_mon = "INSERT INTO %s_00 (HouseID, Data, Date, Hour, Minute) \
        Select TP.HouseID, TP.Data, TP.Date, TP.Hour, TP.Minute \
        FROM %s.%s TP" % (HN, 'House_Sets',TN)


        cur.execute(into_dt_mon)