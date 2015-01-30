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



    AverageDays = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        query = "SELECT AVG(A.DATAS) FROM \
        ( (SELECT SUM(Data) AS DATAS \
         FROM %s  GROUP BY Date) A )" % (TN)
        cur.execute(query)
        AverageDay = cur.fetchone()[0]

        AverageDays.append(float(AverageDay))

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

    data = zip(AverageDays,Occupants)

    column_names = ['AverageDay', 'Occupancy']

    print arff.dump('Average_Day_Weekly.arff',data, relation='Average_Day_Weekly', names = column_names)

    out = csv.writer(open("Average_Day_Weekly.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data)):
        ToBePrinted = list(data[i])
        out.writerow(ToBePrinted)
    print data


