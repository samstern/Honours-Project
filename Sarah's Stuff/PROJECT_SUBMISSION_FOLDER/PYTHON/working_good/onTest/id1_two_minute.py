#!/usr/bin/python

import MySQLdb as mdb
from functions import *
import matplotlib.pyplot as plt




con = mdb.connect('localhost', 'root', '', 'test');
with con:

        cur = con.cursor(mdb.cursors.DictCursor)
        thing = GetInfoId1(cur)
        for HN in thing:
            HN = str(HN)
            HN = HN.split()
            HN = HN[2].split("'")[1]

            SumHourly(cur,HN)
            result = AvgPerHour(cur,'temp', HN)
            time = []
            avg = []

            for i in range(1,len(result)):
                time.append(result[i][0])
                avg.append(result[i][1])

            figs = plt.bar(time,avg)
            plt.title(result[0] +' Average Per Hour')
            plt.ylim((0,50000))
            plt.xticks(range(0,24))
            plt.show()

            result2 = AvgPerHourDay(cur,'temp',HN)
        #print result2
            length =  len(result2)-1
            dy = []
            hr = []
            reading = []

            for i in range(1,len(result2)):
                dy.append(result2[i][0])
                hr.append(result2[i][1])
                reading.append(result2[i][2])

            figure1 = plt.plot(hr[0:24],reading[0:24], label = 'Monday')
            figure2 = plt.plot(hr[24:48],reading[24:48], label = 'Tuesday')
            figure3 = plt.plot(hr[48:72],reading[48:72], label = 'Wednesday')
            figure4 = plt.plot(hr[72:96],reading[72:96], label = 'Thursday')
            figure5 = plt.plot(hr[96:120],reading[96:120], label = 'Friday')
            figure6 = plt.plot(hr[120:144],reading[120:144], label = 'Saturday')
            figure7 = plt.plot(hr[144:168],reading[144:168], label = 'Sunday')
            plt.title(result2[0] +' AvgPerHourDay')
            plt.xlim((0,23))
            plt.xticks(range(0,24))
            plt.ylim((0,60000))
            plt.legend(loc='upper left')
            plt.show()



            result3 = AvgPerDay(cur,'temp',HN)
        #print result3
            x = []
            y = []
            for i in range(1,len(result3)):
                y.append(result3[i][0])
                x.append(result3[i][1])

            fig = plt.bar(range(0,7),x)
            plt.xticks(range(0,7))
            plt.ylim((0,50000))
            plt.title(result3[0] + ' AvgPerDay')
            plt.show()

            cur.execute("drop table if exists temp")