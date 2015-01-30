#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import *

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:



    AverageDays = []
    StdDays = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        query = query = "SELECT AVG(A.DATAS), STD(A.DATAS) FROM( \
        (SELECT SUM(Data) AS DATAS\
        FROM %s  GROUP BY Date) A )" % (TN)
        cur.execute(query)
        AverageDay, StdDay = cur.fetchone()

        AverageDays.append(float(AverageDay))
        StdDays.append(float(StdDay))

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
    data = zip(AverageDays,StdDays,Occupants)


    column_names = ['AverageDay','StdDay', 'Occupancy']

    print arff.dump('STD_Average_Day_Monthly.arff',data, relation='STD_Average_Day_Monthly', names = column_names)

    out = csv.writer(open("STD_Average_Day_Monthly.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data)):
        ToBePrinted = list(data[i])
        out.writerow(ToBePrinted)



