#!/usr/bin/python

import MySQLdb as mdb
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import arff
from functions import *

con = mdb.connect('localhost', 'root', '', 'split');
with con:



    Average = []
    Times = []
    Stdv = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")
    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        SumHourly(cur,TN)
        result = StdAvgPerHour(cur,'temp', TN)
        time = []
        avg = []
        std = []

        for i in range(1,len(result)):
                time.append(result[i][0])
                avg.append(result[i][1])
                std.append(result[i][2])
        Average.append(avg)
        Times.append(time)
        Stdv.append(std)

        query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])
        Occupants.append(Occupancy)

        cur.execute("drop table if exists temp")

    Occup = [Occupancy] * 24

    data = zip(Times,Average,Occupants)
    data2 = zip(Times,Average)
    data3 = zip(Average,Occupants)
    data4 = zip(Average,Stdv,Occupants)

    AllTimes = []
    AllAvg = []
    AllNumPeople = []


    data5 = []
    for i in range(len(data4)):
        h = tuple(data4[i][0]) + tuple(data4[i][1],) + (data4[i][2],)
        data5.append(h)


    arff.dump('StdvAvgHourAndClass.arff',data5, relation='StdAvgHourAndClass', names = ['a00','a01','a02','a03',\
    'a04','a05','a06','a07','a08','a09','a10','a11','a12','a13', \
    'a14','a15','a16','a17','a18','a19','a20','a21','a22','a23', \
    's00','s01','s02','s03',\
    's04','s05','s06','s07','s08','s09','s10','s11','s12','s13', \
    's14','s15','s16','s17','s18','s19','s20','s21','s22','s23', \
    'Occupancy'])