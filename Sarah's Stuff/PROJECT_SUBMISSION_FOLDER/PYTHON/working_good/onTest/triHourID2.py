#!/usr/bin/python

import MySQLdb as mdb
from functions import *
import matplotlib.pyplot as plt

def AvgPerTriHourDay(cursor,Table,HouseNumber):
    AvgHourDaily = []
    HouseNumber = HouseNumber.split('_')[1]
    AvgHourDaily.append(HouseNumber)
    Parts = range(1,9)
    Day_of_the_week = "date_format(Date, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        for part in Parts:
            query = "select AVG(Data) as AvgHourDay \
            from %s where SectionOfDay = %s and %s = %s" % (Table,part, Day_of_the_week, day)
            cursor.execute(query)
            avd = cursor.fetchone()
            avd = avd["AvgHourDay"]
            avd = float(avd)
            AvgHourDaily.append([day,part,avd])
    return AvgHourDaily

def AvgPerTriHour(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber.split('_')[1]
    AvgHourly.append(HouseNumber)
    Parts = range(1,9)
    for part in Parts:

        """query = "select sum(Data)/count(distinct Date) as Average \
        from %s where Hour = %s" % (Table,hour)"""
        query = "SELECT avg(Data) as Average \
        from %s where SectionOfDay = %s" % (Table, part)
        cursor.execute(query)
        av = cursor.fetchone()
        av = av["Average"]
        av = float(av)
        AvgHourly.append([part,av])
    return AvgHourly



con = mdb.connect('localhost', 'root', '', 'test');
with con:

        cur = con.cursor(mdb.cursors.DictCursor)
        thing = GetInfoId2(cur)
        for HN in thing:
            HN = str(HN)
            HN = HN.split()
            HN = HN[2].split("'")[1]
            SumTriHourly(cur,HN)

            result = AvgPerTriHour(cur,'temp', HN)
            time = []
            avg = []

            for i in range(1,len(result)):
                time.append(result[i][0])
                avg.append(result[i][1])

            figs = plt.bar(time,avg)
            plt.title(result[0] +' Average Per Hour')
            plt.ylim((0,100000))
            plt.xticks(range(0,9))
            plt.show()

            result2 = AvgPerTriHourDay(cur,'temp',HN)
        #print result2
            length =  len(result2)-1
            dy = []
            hr = []
            reading = []

            for i in range(1,len(result2)):
                dy.append(result2[i][0])
                hr.append(result2[i][1])
                reading.append(result2[i][2])

            figure1 = plt.plot(hr[0:8],reading[0:8], label = 'Monday')
            figure2 = plt.plot(hr[8:16],reading[8:16], label = 'Tuesday')
            figure3 = plt.plot(hr[16:24],reading[16:24], label = 'Wednesday')
            figure4 = plt.plot(hr[24:32],reading[24:32], label = 'Thursday')
            figure5 = plt.plot(hr[32:40],reading[32:40], label = 'Friday')
            figure6 = plt.plot(hr[40:48],reading[40:48], label = 'Saturday')
            figure7 = plt.plot(hr[48:56],reading[48:56], label = 'Sunday')
            plt.title(result2[0] +' AvgPerHourDay')
            plt.xlim((1,8))
            plt.xticks(range(1,8))
            plt.ylim((0,100000))
            plt.legend(loc='upper left')
            plt.show()


            cur.execute("drop table if exists temp")

