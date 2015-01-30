#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
from functions import AvgPerHourDay, SumHourly

con = mdb.connect('localhost', 'root', '', 'split');
with con:



    Average = []
    Hours = []
    Days = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHourly(cur,TN)
        result = AvgPerHourDay(cur,'temp', TN)
        day = []
        hour = []
        avg = []

        for i in range(1,len(result)):
                day.append(result[i][0])
                hour.append(result[i][1])
                avg.append(result[i][2])
        Average.append(avg)
        Hours.append(hour)
        Days.append(day)

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])
        Occupants.append(Occupancy)

        cur.execute("drop table if exists temp")

    # Repeat the list occupancy 168 times, because 7 days and 24 hours, 7*24 = 168
    Occup = [Occupancy] * 168

    data = zip(Days,Hours,Average,Occupants)
    data2 = zip(Days,Average)
    data3 = zip(Average,Occupants)


    data4 = []
    for i in range(len(data3)):
        h = tuple(data3[i][0]) + (data3[i][1],)
        data4.append(h)


    # 00_Monday, 01_Monday, ..., 23_Monday
    # 00_Tuesday, 01_Tuesday, ..., 23_Tuesday
    #...
    # 00_Sunday, 01_Sunday, ..., 23_Sunday

    TheDays =["Monday", "Tuesday", "Wednesday", "Thursday", \
            "Friday", "Saturday", "Sunday"]


    NumberedDays = []

    for day in TheDays:
        for i in range (0,24):
            d = '%s_%s' % (i,day)
            NumberedDays.append(d)

    NumDayClass = NumberedDays + ['class']

    print arff.dump('AvgHourDayOfWeekAndClass.arff',data4, relation='AvgHourDayOfWeekAndClass', names = NumDayClass)









