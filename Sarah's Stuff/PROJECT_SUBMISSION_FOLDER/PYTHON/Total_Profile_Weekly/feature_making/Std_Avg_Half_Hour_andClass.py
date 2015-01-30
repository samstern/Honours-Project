#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import *

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
with con:



    Average = []
    Times = []
    Stdv = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHalfHourly(cur,TN)
        result = StdAvgPerHalfHour(cur,'temp', TN)
        time = []
        avg = []
        std = []

        for i in range(1,len(result)):
                time.append(result[i][0])
                avg.append(result[i][1])
                std.append(result[i][2])
        Average.append(avg)
        Times.append(time)
        Stdv.append(std)

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])
        """# BINARY, FEW VS MANY
        if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0"""
        Occupants.append(occupancy)


        cur.execute("drop table if exists temp")

    #Occup = [Occupancy] * 24

    data = zip(Times,Average,Occupants)
    data2 = zip(Times,Average)
    data3 = zip(Average,Occupants)
    data4 = zip(Average,Stdv,Occupants)

    AllTimes = []
    AllAvg = []
    AllNumPeople = []


    data5 = []
    for i in range(len(data4)):
        h = tuple(data4[i][0]) + tuple(data4[i][1],) + (data4[i][2],)
        data5.append(h)

    print data4[0]
    print data5[0]

    AvgNumbered = []

    StdNumbered = []

    for i in range (0,48):
            d = 'a%s' % (i)
            AvgNumbered.append(d)

            e = 's%s' % (i)
            StdNumbered.append(e)

    column_names = AvgNumbered + StdNumbered + ['class']


    arff.dump('Weekly_StdvAvg_HALF_HourAndClass.arff',data5, relation='Weekly_StdAvg_HALF_HourAndClass', names = column_names)



    out = csv.writer(open("Weekly_StdvAvg_HALF_HourAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data5)):
        ToBePrinted = list(data5[i])
        out.writerow(ToBePrinted)