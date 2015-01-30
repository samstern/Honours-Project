#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import AvgPerHour, SumHourly

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');

column_names = ['00','01','02','03','04','05','06', \
                '07','08','09','10','11','12','13','14' \
                ,'15','16','17','18','19','20','21','22','23','class']
with con:



    Average = []
    Times = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHourly(cur,TN)
        result = AvgPerHour(cur,'temp', TN)
        time = []
        avg = []

        for i in range(1,len(result)):
                time.append(result[i][0])
                avg.append(result[i][1])
        Average.append(avg)
        Times.append(time)

        """figs = plt.bar(time,avg)
        plt.title(result[0] +' Average Per Hour')
        plt.ylim((0,50000))
        plt.xticks(range(0,24))
        plt.show()"""


        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])
        """# Binary class, few vs many
        if Occupancy > 3:
            Occupancy = 1
        else:
            Occupancy = 0"""
        Occupants.append(Occupancy)

        cur.execute("drop table if exists temp")

    Occup = [Occupancy] * 24

    data = zip(Times,Average,Occupants)
    data2 = zip(Times,Average)
    data3 = zip(Average,Occupants)

    AllTimes = []
    AllAvg = []
    AllNumPeople = []
    for i in range(len(data)):
        TimeOfDay = data[i][0]
        AllTimes.extend(TimeOfDay)

        AveragePerHour = data[i][1]
        AllAvg.extend(AveragePerHour)

        NumberOfPeople = data[i][2]
        NumberOfPeople = [NumberOfPeople] * 24
        AllNumPeople.extend(NumberOfPeople)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(AllTimes,AllNumPeople,AllAvg)

    ax.set_xlabel('TimeOfDay')
    ax.set_zlabel('AveragePerHour')
    ax.set_ylabel('NumberOfPeople')


    #plt.show()

    data4 = []
    for i in range(len(data3)):
        h = tuple(data3[i][0]) + (data3[i][1],)
        data4.append(h)


    #out = csv.writer(open("AvgHourAndClass.csv","w"), delimiter = ',', quoting = csv.QUOTE_ALL)
    out = csv.writer(open("WeeklyAvgHourAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data4)):
        ToBePrinted = list(data4[i])
        out.writerow(ToBePrinted)


    print arff.dump('TotalProfileWeekly_AvgHourAndClass.arff',data4, relation='TotalProfileWeekly_AvgHourAndClass', names = ['00','01','02','03',\
    '04','05','06','07','08','09','10','11','12','13', \
    '14','15','16','17','18','19','20','21','22','23','class'])








