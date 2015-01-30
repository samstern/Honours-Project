#!/usr/bin/python

import MySQLdb as mdb
import matplotlib.pyplot as plt
import arff

con = mdb.connect('localhost', 'root', '', 'split');
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
        MonthTotals.append(int(SumMonth))

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])
        Occupants.append(Occupancy)


    plt.scatter(Occupants,MonthTotals,alpha = 0.2)
    plt.show()

    plt.scatter(MonthTotals,Occupants, alpha = 0.2)
    plt.show()

    data = zip(MonthTotals,Occupants)

    #arff.dump('MonthSumAndOccupancy.arff', data, relation='MonthySumAndOccupancy', names = ['MonthyTotals','class'])
    #print arff.dumps(data, relation="thing",names=['MonthlyTotals','class'])