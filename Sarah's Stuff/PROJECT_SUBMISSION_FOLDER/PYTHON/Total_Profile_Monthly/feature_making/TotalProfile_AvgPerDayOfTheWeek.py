#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
import csv
from functions import AvgPerDay, SumHourly

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:



    Average = []
    Days = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHourly(cur,TN)
        result = AvgPerDay(cur,'temp', TN)
        day = []
        avg = []

        for i in range(1,len(result)):
                day.append(result[i][0])
                avg.append(result[i][1])
        Average.append(avg)
        Days.append(day)

        """figs = plt.bar(time,avg)
        plt.title(result[0] +' Average Per Day')
        plt.ylim((0,50000))
        plt.xticks(range(0,7))
        plt.show()"""


        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        occupancy = int(cur.fetchone()[0])

        # Binary class, few or many people
        if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0
        Occupants.append(occupancy)

        cur.execute("drop table if exists temp")

    # Repeat the list occupancy 7 times, because 7 days
    Occup = [occupancy] * 7

    data = zip(Days,Average,Occupants)
    data2 = zip(Days,Average)
    data3 = zip(Average,Occupants)

    """AllDays = []
    AllAvg = []
    AllNumPeople = []

    ListDays = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    DayNumbers = list(enumerate(ListDays))
    print DayNumbers

    for i in range(len(data)):
        TheDay = data[i][0]
        AllDays.extend(TheDay)

        AveragePerDay = data[i][1]
        AllAvg.extend(AveragePerDay)

        NumberOfPeople = data[i][2]
        NumberOfPeople = [NumberOfPeople] * 7
        AllNumPeople.extend(NumberOfPeople)

    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(AllDays,AllAvg,AllNumPeople)

    ax.set_xlabel('TheDay')
    ax.set_ylabel('AveragePerHour')
    ax.set_zlabel('NumberOfPeople')


    plt.show()"""

    data4 = []
    for i in range(len(data3)):
        h = tuple(data3[i][0]) + (data3[i][1],)
        data4.append(h)



    print arff.dump('BINARY_TotalProfile_AvgDayOfWeekAndClass.arff',data4, relation='BINARY_TotalProfile_AvgDayOfWeekAndClass', names = ['monday','tuesday', \
    'wednesday','thursday','friday','saturday','sunday','class'])

    column_names = ['monday','tuesday','wednesday','thursday','friday','saturday','sunday','class']

    out = csv.writer(open("BINARY_TotalProfile_AvgDayOfWeekAndClass.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data4)):
        ToBePrinted = list(data4[i])
        out.writerow(ToBePrinted)









