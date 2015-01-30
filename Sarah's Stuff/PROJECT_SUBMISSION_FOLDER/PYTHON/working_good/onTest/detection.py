#!/usr/bin/python

import MySQLdb as mdb
from GetHouseIDs import GetHouseIDs
from types import NoneType

con = mdb.connect('localhost', 'root', '', 'test');
with con:
    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    # Get the household ID numbers
    HNDbs = GetHouseIDs(cur)
    for HN in HNDbs:
        dates1 = set()
        appl1 = set()
        id1 = set()
        dates2 = set()
        appl2 = set()
        id2 = set()
        dates3 = set()
        appl3 = set()
        id3 = set()
        query1 = "select distinct Date(hes.TimeInterval) as Date, hes.Appliance \
        FROM hes_database.appliance_group_data hes \
        WHERE Household = %s AND IntervalID = 1" % (HN)
        cur.execute(query1)
        rows = cur.fetchall()
        for row in rows:
            if row != NoneType:
                Date = (str(row["Date"]))
                Appl = row["Appliance"]
                dates1.add(Date)
                appl1.add(Appl)
                id1.add((Date,Appl))
            else:
                dates1.add(0)
                appl1.add(0)
                id1.add(0)

        query2 = "select distinct Date(hes.TimeInterval) as Date, hes.Appliance \
        FROM hes_database.appliance_group_data hes \
        WHERE Household = %s AND IntervalID = 2" % (HN)
        cur.execute(query2)
        rows = cur.fetchall()
        for row in rows:
            if row != NoneType:
                Date = (str(row["Date"]))
                Appl = row["Appliance"]
                dates2.add(Date)
                appl2.add(Appl)
                id2.add((Date,Appl))
            else:
                dates2.add(0)
                appl2.add(0)
                id2.add(0)

        query3 = "select distinct Date(hes.TimeInterval) as Date, hes.Appliance \
        FROM hes_database.appliance_group_data hes \
        WHERE Household = %s AND IntervalID = 3" % (HN)
        cur.execute(query3)
        rows = cur.fetchall()
        for row in rows:
            if row != NoneType:
                Date = (str(row["Date"]))
                Appl = row["Appliance"]
                dates3.add(Date)
                appl3.add(Appl)
                id3.add((Date,Appl))
            else:
                dates3.add(0)
                appl3.add(0)
                id3.add(0)

        ##########

        print 'HouseNumber', HN

        # Alone:
        print 'ALONE'


        print 'In 1'
        print 'Dates'
        print len(dates1)
        print 'Appliance'
        print len(appl1)

        print 'In 2'
        print 'Dates'
        print len(dates2)
        print 'Appliance'
        print len(appl2)

        print 'In 3'
        print 'Dates'
        print len(dates3)
        print 'Appliance'
        print len(appl3)


        # Differences
        print 'DIFFERENCES'
        # ID1 and ID2 difference
        print 'In 1 not in 2'
        print 'Date'
        diffdates12 = dates1 - dates2
        print len(diffdates12)
        print 'Appliances'
        diffappl12 = appl1 - appl2
        print len(diffappl12)

        # ID2 and ID1 difference
        print 'In 2 not in 1'
        print 'Date'
        diffdates21 = dates2 - dates1
        print len(diffdates21)
        print 'Appliances'
        diffappl21 = appl2 - appl1
        print len(diffappl21)

        # ID1 and ID3 difference
        print 'In 1 not in 3'
        print 'Date'
        diffdates13 = dates1 - dates3
        print len(diffdates13)
        print 'Appliances'
        diffappl13 = appl1 - appl3
        print len(diffappl13)

        # ID3 and ID1 difference
        print 'In 3 not in 1'
        print 'Date'
        diffdates31 = dates3 - dates1
        print len(diffdates31)
        print 'Appliances'
        diffappl31 = appl3 - appl1
        print len(diffappl31)

        # ID2 and ID3 difference
        print 'In 2 not in 3'
        print 'Date'
        diffdates23 = dates2 - dates3
        print len(diffdates23)
        print 'Appliances'
        diffappl23 = appl2 - appl3
        print len(diffappl23)

        # ID3 and ID1 difference
        print 'In 3 not in 2'
        print 'Date'
        diffdates32 = dates3 - dates2
        print len(diffdates32)
        print 'Appliances'
        diffappl32 = appl3 - appl2
        print len(diffappl32)


        # ID2 and ID1 same
        sameid12 = id1 & id2
        sameid13 = id1 & id3

        sameid23 = id2 & id3

        samedate12 = dates1 & dates2
        samedate13 = dates1 & dates3
        samedate23 = dates2 & dates3

        sameappl12 = appl1 & appl2
        sameappl13 = appl1 & appl3
        sameappl23 = appl2 & appl3

        print 'SAME'


        # 1 and 2
        print 'Same dates 1 and 2'
        print len(samedate12)

        print 'Same appliances 1 and 2'
        print len(sameappl12)

        print 'Same both 1 and 2'
        print len(sameid12)

        # 1 and 3
        print 'Same dates 1 and 3'
        print len(samedate13)

        print 'Same appliances 1 and 3'
        print len(sameappl13)

        print 'Same both 1 and 3'
        print len(sameid13)

        # 2 and 3
        print 'Same dates 2 and 3'
        print len(samedate23)

        print 'Same appliances 2 and 3'
        print len(sameappl23)

        print 'Same both 2 and 3'
        print len(sameid23)
        print ' '
        print ' '