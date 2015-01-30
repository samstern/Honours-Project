#!/usr/bin/python

import MySQLdb as mdb
import matplotlib.pyplot as plt
import arff
import csv
import random
import numpy as np
con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:

    MonthTotals = []
    Occupants = []

    cur = con.cursor()
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        query = "Select SUM(Data) FROM %s" % (TN)
        cur.execute(query)
        SumMonthly = cur.fetchone()
        SumMonth = SumMonthly[0]
        # The readings are all in 0.1Wh, multiply by 10 to get Wh
        # then divide by 1000 to get kWh.
        # same as diving by 100
        SumMonth = float(SumMonth)/100.00
        MonthTotals.append(float(SumMonth))

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])
        # Binary class, few vs many
        """if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0"""
        Occupants.append(occupancy)

    print min(MonthTotals)
    #Want to jitter the plots because some of the data points lie in the same place
    jitter = 0.2

    #Occupants = [O + random.uniform(-jitter,jitter) for O in Occupants]

    xticks = np.arange(1,7,1)
    yticks = np.arange(0,250000,25000)


    plt.scatter(Occupants,MonthTotals,alpha = 0.5)
    plt.title('Monthly Total and Occupancy')
    plt.xlabel('Occupants')
    plt.ylabel('Monthly Total(kWh)')
    plt.xticks(xticks)
    plt.yticks(yticks)
    plt.ylim(0,200000)
    plt.show()


    data = zip(MonthTotals,Occupants)

    arff.dump('TotalProfile_MonthSumAndOccupancy.arff', data, relation='TotalProfile_MonthySumAndOccupancy', names = ['MonthyTotals','class'])
    print arff.dumps(data, relation="thing",names=['MonthlyTotals','class'])

    column_names = ['MonthlyTotals','class']
    out = csv.writer(open("TotalProfile_MonthSumAndOccupancy.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data)):
        ToBePrinted = list(data[i])
        out.writerow(ToBePrinted)