#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import AvgPerHour, SumHourly

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');

with con:



    AverageHours = []
    StdHours = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        cur.execute("drop table if exists temp")
        SumHourly(cur,TN)
        query = "SELECT AVG(Data), STD(Data) FROM temp"
        cur.execute(query)
        AverageHour,StdHour = cur.fetchone()
        AverageHours.append(float(AverageHour))
        StdHours.append(float(StdHour))

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])

        # Binary class,few vs many

        """if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0"""
        Occupants.append(occupancy)
    data = zip(AverageHours,Occupants)


    column_names = ['AverageHour','StdHour','Occupancy']

    print arff.dump('STD_Average_Hour_Weekly.arff',data, relation='STD_Average_Hour_Weekly', names = column_names)

    out = csv.writer(open("STD_Average_Hour_Weekly.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data)):
        ToBePrinted = list(data[i])
        out.writerow(ToBePrinted)