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
    StandardDev = []
    Hours = []
    Days = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHalfHourly(cur,TN)
        result = StdAvgPerHalfHourDay(cur,'temp', TN)
        day = []
        hour = []
        avg = []
        stdv = []

        for i in range(1,len(result)):
                day.append(result[i][0])
                hour.append(result[i][1])
                avg.append(result[i][2])
                stdv.append(result[i][3])
        Average.append(avg)
        StandardDev.append(stdv)
        Hours.append(hour)
        Days.append(day)

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])

        # binary class, few vs many

        """if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0"""

        Occupants.append(occupancy)

        cur.execute("drop table if exists temp")

    # Repeat the list occupancy 168 times, because 7 days and 24 hours, 7*24 = 168
    #Occup = [Occupancy] * 168

    data = zip(Days,Hours,Average,Occupants)
    data2 = zip(Days,Average)
    data3 = zip(Average,Occupants)

    data4 = zip(Average,StandardDev,Occupants)


    data5 = []
    for i in range(len(data4)):
        h = tuple(data4[i][0]) + tuple(data4[i][1],) + (data4[i][2],)
        data5.append(h)


    # 00_Monday, 01_Monday, ..., 23_Monday
    # 00_Tuesday, 01_Tuesday, ..., 23_Tuesday
    #...
    # 00_Sunday, 01_Sunday, ..., 23_Sunday

    TheDays =["Monday", "Tuesday", "Wednesday", "Thursday", \
            "Friday", "Saturday", "Sunday"]


    AvgNumberedDays = []
    StdNumberedDays = []

    for day in TheDays:
        for i in range (0,48):
            d = 'a%s_%s' % (i,day)
            AvgNumberedDays.append(d)

            e = 's%s_%s' % (i,day)
            StdNumberedDays.append(e)


    NumDayClass = AvgNumberedDays + StdNumberedDays + ['class']

    print arff.dump('Weekly_StdvAvg_HALF_HourDayOfWeekAndClass.arff',data5, relation='Weekly_StvAvg_HALF_HourDayOfWeekAndClass', names = NumDayClass)



    column_names = NumDayClass
    out = csv.writer(open("Weekly_StdvAvg_HALF_HourDayOfWeekAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data5)):
        ToBePrinted = list(data5[i])
        out.writerow(ToBePrinted)