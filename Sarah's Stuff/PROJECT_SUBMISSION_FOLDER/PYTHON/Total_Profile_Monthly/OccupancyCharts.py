#!/usr/bin/python


import MySQLdb as mdb
from functions import *
import matplotlib.pyplot as plt
from types import NoneType
import random




con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:

        #cur = con.cursor(mdb.cursors.DictCursor)
        cur = con.cursor()

        Ones  = IDandOccupancy(cur,1)
        Twos  = IDandOccupancy(cur,2)
        Threes= IDandOccupancy(cur,3)
        Fours = IDandOccupancy(cur,4)
        Fives = IDandOccupancy(cur,5)
        Sixes = IDandOccupancy(cur,6)

        SixesHNs = []

        for s in Ones:
            title = ' Average Per Day.Occupants: 1'
            xlabel = 'Hour of the Day'
            ylabel = 'Avg (kWh)'
            s = str(s)
            query = "Show tables like %s" % ("'%" + s + "%'")

            cur.execute(query)

            IDs = []

            alls = cur.fetchall()

            if len(alls) == 0:
                print 'None'
            else:

                if len(alls) > 1:
                    for i in range (0,len(alls)):
                        SixesHNs.append(alls[i])
                else:
                    SixesHNs.append(alls[0])

        MonthTotals = []
        Occupants = [6] * len(SixesHNs)
        for i in range (0,len(SixesHNs)):
            HN = SixesHNs[i]
            cur.execute("drop table if exists temp")

            SumHourly(cur,HN)
            result3 = AvgPerHour(cur,'temp',HN)

            readings = []
            hours = []
            for i in range(1,len(result3)):
                hours.append(result3[i][0])
                readings.append((result3[i][1])/100.00)

            day = [0,1,2,3,4,5,6]
            #Want to jitter the plots because some of the data points lie in the same place
            jitter = 0.2

            day = [D + random.uniform(-jitter,jitter) for D in day]

            #Labels = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

            fig = plt.scatter(hours,readings)
            plt.xticks(range(0,24))
            plt.ylim((0,300))
            plt.title(title)
            plt.xlabel(xlabel)
            plt.ylabel(ylabel)
            cur.execute("drop table if exists temp")
        plt.show()



"""SumHourly(cur,HN)
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
            plt.show()"""

"""query = "Select SUM(Data) FROM %s" % (HN)
            cur.execute(query)
            SumMonthly = cur.fetchone()
            SumMonth = SumMonthly[0]
            MonthTotals.append(int(SumMonth))

        print MonthTotals
        print Occupants

        figs = plt.scatter(Occupants,MonthTotals)
        plt.show()"""

"""query2 = "Select hes.Occupancy \
        FROM hes_database.home_information hes \
        WHERE hes.HouseID = %s" % (HN)
        cur.execute(query2)
        Occupancy = int(cur.fetchone()[0])
        Occupants.append(Occupancy)


        plt.scatter(Occupants,MonthTotals,alpha = 0.2)
        plt.show()

        plt.scatter(MonthTotals,Occupants, alpha = 0.2)
        plt.show()"""

"""            SumHourly(cur,HN)
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

            cur.execute("drop table if exists temp")"""