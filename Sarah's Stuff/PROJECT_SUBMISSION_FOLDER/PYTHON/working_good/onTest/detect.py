#!/usr/bin/python

import MySQLdb as mdb
from GetHouseIDs import GetHouseIDs
from types import NoneType
import csv

con = mdb.connect('localhost', 'root', '', 'test');
column_names =['HouseID','Dates1','Appliances1','Both1', \
               'Dates2','Appliances2', 'Both2', \
               'Dates3', 'Appliances3', 'Both3', \
               'DiffDate12', 'DiffAppl12', 'DiffBoth12', \
               'DiffDate21', 'DiffAppl21', 'DiffBoth21', \
               'DiffDate13', 'DiffAppl13', 'DiffBoth13', \
               'DiffDate31', 'DiffAppl31', 'DiffBoth31', \
               'DiffDate23', 'DiffAppl23', 'DiffBoth23', \
               'DiffDate32', 'DiffAppl32', 'DiffBoth32', \
               'SameDate12', 'SameAppl12', 'SameBoth12', \
               'SameDate13', 'SameAppl13', 'SameBoth13', \
               'SameDate23', 'SameAppl23', 'SameBoth23']
with con:
    out = csv.writer(open("mytest.csv","w"), delimiter = ',', quoting = csv.QUOTE_ALL)
    out.writerow(column_names)
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



        # Differences
        # ID1 and ID2 difference
        diffdates12 = dates1 - dates2
        diffappl12 = appl1 - appl2
        diffboth12 = id1 - id2

        # ID2 and ID1 difference
        diffdates21 = dates2 - dates1
        diffappl21 = appl2 - appl1
        diffboth21 = id2 - id1

        # ID1 and ID3 difference
        diffdates13 = dates1 - dates3
        diffappl13 = appl1 - appl3
        diffboth13 = id1 - id3

        # ID3 and ID1 difference
        diffdates31 = dates3 - dates1
        diffappl31 = appl3 - appl1
        diffboth31 = id3 - id1

        # ID2 and ID3 difference
        diffdates23 = dates2 - dates3
        diffappl23 = appl2 - appl3
        diffboth23 = id2 - id3


        # ID3 and ID1 difference
        diffdates32 = dates3 - dates2
        diffappl32 = appl3 - appl2
        diffboth32 = id3 - id2


        # ID2 and ID1 same
        sameboth12 = id1 & id2
        sameboth13 = id1 & id3
        sameboth23 = id2 & id3

        samedate12 = dates1 & dates2
        samedate13 = dates1 & dates3
        samedate23 = dates2 & dates3

        sameappl12 = appl1 & appl2
        sameappl13 = appl1 & appl3
        sameappl23 = appl2 & appl3


        ToBePrinted = [HN, len(dates1), len(appl1), len(id1), \
                       len(dates2), len(appl2), len(id2), \
                       len(dates3), len(appl3), len(id3), \
                       len(diffdates12), len(diffappl12), len(diffboth12), \
                       len(diffdates21), len(diffappl21), len(diffboth21), \
                       len(diffdates13), len(diffappl13), len(diffboth13), \
                       len(diffdates31), len(diffappl31), len(diffboth31), \
                       len(diffdates23), len(diffappl23), len(diffboth23), \
                       len(diffdates32), len(diffappl32), len(diffboth32), \
                       len(samedate12), len(sameappl12), len(sameboth12), \
                       len(samedate13), len(sameappl13), len(sameboth13), \
                       len(samedate23), len(sameappl23), len(sameboth23)]

        out.writerow(ToBePrinted)