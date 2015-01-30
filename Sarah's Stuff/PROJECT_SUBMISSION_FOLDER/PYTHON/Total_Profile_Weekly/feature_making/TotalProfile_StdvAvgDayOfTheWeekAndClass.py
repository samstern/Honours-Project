#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import StdAvgPerDay, SumHourly

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
with con:



    Average = []
    StandardDev = []
    Days = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHourly(cur,TN)
        result = StdAvgPerDay(cur,'temp', TN)
        day = []
        avg = []
        stdv = []

        for i in range(1,len(result)):
                day.append(result[i][0])
                avg.append(result[i][1])
                stdv.append(result[i][2])
        Average.append(avg)
        Days.append(day)
        StandardDev.append(stdv)


        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])

        # Binary class, few vs many
        """if Occupancy > 3:
            Occupancy = 1
        else:
            Occupancy = 0"""
        Occupants.append(Occupancy)

        cur.execute("drop table if exists temp")

    # Repeat the list occupancy 7 times, because 7 days
    Occup = [Occupancy] * 7

    data = zip(Days,Average,Occupants)
    data2 = zip(Days,Average)
    data3 = zip(Average,Occupants)
    data4 = zip(Average,StandardDev,Occupants)


    data5 = []
    for i in range(len(data4)):
        h = tuple(data4[i][0]) + tuple(data4[i][1],) + (data4[i][2],)
        data5.append(h)



    print arff.dump('TotalProfileWeklyy_StdAvgDayOfWeekAndClass.arff',data5, relation='TotalProfileWeekly_StdAvgDayOfWeekAndClass', names = ['amonday','atuesday', \
    'awednesday','athursday','afriday','asaturday','asunday','smonday','stuesday', \
    'swednesday','sthursday','sfriday','ssaturday','ssunday','class'])


    column_names = ['amonday','atuesday', \
    'awednesday','athursday','afriday','asaturday','asunday','smonday','stuesday', \
    'swednesday','sthursday','sfriday','ssaturday','ssunday','class']

    out = csv.writer(open("WeeklyStdAvgDayOfWeekAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data5)):
        ToBePrinted = list(data5[i])
        out.writerow(ToBePrinted)






