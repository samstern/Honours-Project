#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import *

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
column_names = []
aa = range(0,48)
for a in aa:
    column_names.append(str(a))

column_names = column_names + ['class']

print column_names
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

        SumHalfHourly(cur,TN)

        result = AvgPerHalfHour(cur,'temp', TN)

        Average.append(result[1:])
        #Times.append(time)

        """figs = plt.bar(time,avg)
        plt.title(result[0] +' Average Per Hour')
        plt.ylim((0,50000))
        plt.xticks(range(0,24))
        plt.show()"""


        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])
        # Binary occupancy classes few vs many
        if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0

        Occupants.append(occupancy)

        cur.execute("drop table if exists temp")

    Occup = [occupancy] * 24

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

    print data4[0]


    #out = csv.writer(open("AvgHourAndClass.csv","w"), delimiter = ',', quoting = csv.QUOTE_ALL)
    out = csv.writer(open("BINARY_Weekly_Avg_HALF_HourAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    print 'type', type(data4[0][0])
    for i in range(0,len(data4)):
        ToBePrinted = list(data4[i])
        out.writerow(ToBePrinted)


    print arff.dump('BINARY_Weekly_Avg_HALF_HourAndClass.arff',data4, relation='BINARY_Weekly_Avg_HALF_HourAndClass', names = ['0', \
     '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', \
     '11', '12', '13', '14', '15', '16', '17', '18', '19', \
      '20', '21', '22', '23', '24', '25', '26', '27', '28', \
       '29', '30', '31', '32', '33', '34', '35', '36', '37', \
        '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', 'class']
)