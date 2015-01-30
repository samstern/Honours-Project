#!/usr/bin/python

import MySQLdb as mdb
import math
from functions import ShowAllTablesFromTotalProfileMonthly


con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
with con:

    cur = con.cursor()



    IDs = ShowAllTablesFromTotalProfileMonthly(cur)
    Tables = []
    for tab in IDs:
        TN = str(tab[0])
        Tables.append(TN)
        # Count the number of distinct dates for the table
        NumDaysQuery = "SELECT COUNT(DISTINCT Date) AS NumberOfDays FROM Total_Profile_Monthly.%s" % (TN)
        cur.execute(NumDaysQuery)
        NumberOfDays = cur.fetchone()
        NumberOfDays = NumberOfDays[0]
        NumberOfWeeks = math.floor(NumberOfDays/7)

        # Get the distinct dates from the table

        DatesQuery = "SELECT DISTINCT Date AS DistinctDates FROM Total_Profile_Monthly.%s" % (TN)
        cur.execute(DatesQuery)
        ReturnedDates = cur.fetchall()





        ############### CREATE THE WEEKLY TABLES ###############################
        week1_tab = "create table %s_01 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        week2_tab = "create table %s_02 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        week3_tab = "create table %s_03 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        week4_tab = "create table %s_04 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        week5_tab = "create table %s_05 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        week6_tab = "create table %s_06 (ID mediumint not null auto_increment,\
         HouseID int, Data int, Date Date, Hour int, Minute int, Primary key (ID))" % (TN)

        ########################################################################################


        # The number of tables created depends on the number of full weeks that the montly tables can be split into

        if NumberOfWeeks == 0:
            continue


        if NumberOfWeeks == 1:

            cur.execute(week1_tab)

            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            cur.execute(into_week1_tab)



        if NumberOfWeeks == 2:

            cur.execute(week1_tab)
            cur.execute(week2_tab)


            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            week2Dates = []
            week2Date = ReturnedDates[7:14]
            for i in range(0,7):
                week2Dates.append(str(week2Date[i][0]))
            week2Dates = tuple(week2Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            into_week2_tab = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week2Dates)

            cur.execute(into_week1_tab)
            cur.execute(into_week2_tab)


        if NumberOfWeeks == 3:

            cur.execute(week1_tab)
            cur.execute(week2_tab)
            cur.execute(week3_tab)


            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            week2Dates = []
            week2Date = ReturnedDates[7:14]
            for i in range(0,7):
                week2Dates.append(str(week2Date[i][0]))
            week2Dates = tuple(week2Dates)


            week3Dates = []
            week3Date = ReturnedDates[14:21]
            for i in range(0,7):
                week3Dates.append(str(week3Date[i][0]))
            week3Dates = tuple(week3Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            into_week2_tab = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week2Dates)

            into_week3_tab = 'INSERT INTO %s_03 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week3Dates)

            cur.execute(into_week1_tab)
            cur.execute(into_week2_tab)
            cur.execute(into_week3_tab)


        if NumberOfWeeks == 4:

            cur.execute(week1_tab)
            cur.execute(week2_tab)
            cur.execute(week3_tab)
            cur.execute(week4_tab)


            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            week2Dates = []
            week2Date = ReturnedDates[7:14]
            for i in range(0,7):
                week2Dates.append(str(week2Date[i][0]))
            week2Dates = tuple(week2Dates)


            week3Dates = []
            week3Date = ReturnedDates[14:21]
            for i in range(0,7):
                week3Dates.append(str(week3Date[i][0]))
            week3Dates = tuple(week3Dates)

            week4Dates = []
            week4Date = ReturnedDates[21:28]
            for i in range(0,7):
                week4Dates.append(str(week4Date[i][0]))
            week4Dates = tuple(week4Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            into_week2_tab = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week2Dates)

            into_week3_tab = 'INSERT INTO %s_03 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week3Dates)

            into_week4_tab = 'INSERT INTO %s_04 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week4Dates)


            cur.execute(into_week1_tab)
            cur.execute(into_week2_tab)
            cur.execute(into_week3_tab)
            cur.execute(into_week4_tab)


        if NumberOfWeeks == 5:

            cur.execute(week1_tab)
            cur.execute(week2_tab)
            cur.execute(week3_tab)
            cur.execute(week4_tab)
            cur.execute(week5_tab)


            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            week2Dates = []
            week2Date = ReturnedDates[7:14]
            for i in range(0,7):
                week2Dates.append(str(week2Date[i][0]))
            week2Dates = tuple(week2Dates)


            week3Dates = []
            week3Date = ReturnedDates[14:21]
            for i in range(0,7):
                week3Dates.append(str(week3Date[i][0]))
            week3Dates = tuple(week3Dates)

            week4Dates = []
            week4Date = ReturnedDates[21:28]
            for i in range(0,7):
                week4Dates.append(str(week4Date[i][0]))
            week4Dates = tuple(week4Dates)

            week5Dates = []
            week5Date = ReturnedDates[28:35]
            for i in range(0,7):
                week5Dates.append(str(week5Date[i][0]))
            week5Dates = tuple(week5Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            into_week2_tab = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week2Dates)

            into_week3_tab = 'INSERT INTO %s_03 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week3Dates)

            into_week4_tab = 'INSERT INTO %s_04 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week4Dates)

            into_week5_tab = 'INSERT INTO %s_05 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week5Dates)

            cur.execute(into_week1_tab)
            cur.execute(into_week2_tab)
            cur.execute(into_week3_tab)
            cur.execute(into_week4_tab)
            cur.execute(into_week5_tab)


        if NumberOfWeeks == 6:

            cur.execute(week1_tab)
            cur.execute(week2_tab)
            cur.execute(week3_tab)
            cur.execute(week4_tab)
            cur.execute(week5_tab)
            cur.execute(week6_tab)

            week1Dates = []
            week1Date = ReturnedDates[0:7]
            for i in range(0,7):
                week1Dates.append(str(week1Date[i][0]))
            week1Dates = tuple(week1Dates)

            week2Dates = []
            week2Date = ReturnedDates[7:14]
            for i in range(0,7):
                week2Dates.append(str(week2Date[i][0]))
            week2Dates = tuple(week2Dates)


            week3Dates = []
            week3Date = ReturnedDates[14:21]
            for i in range(0,7):
                week3Dates.append(str(week3Date[i][0]))
            week3Dates = tuple(week3Dates)

            week4Dates = []
            week4Date = ReturnedDates[21:28]
            for i in range(0,7):
                week4Dates.append(str(week4Date[i][0]))
            week4Dates = tuple(week4Dates)

            week5Dates = []
            week5Date = ReturnedDates[28:35]
            for i in range(0,7):
                week5Dates.append(str(week5Date[i][0]))
            week5Dates = tuple(week5Dates)

            week6Dates = []
            week6Date = ReturnedDates[35:42]
            for i in range(0,7):
                week6Dates.append(str(week6Date[i][0]))
            week6Dates = tuple(week6Dates)

            ############# INSERTING INTO THE NEW WEEKLY TABLES ########################
            into_week1_tab = 'INSERT INTO %s_01 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week1Dates)

            into_week2_tab = 'INSERT INTO %s_02 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week2Dates)

            into_week3_tab = 'INSERT INTO %s_03 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week3Dates)

            into_week4_tab = 'INSERT INTO %s_04 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week4Dates)

            into_week5_tab = 'INSERT INTO %s_05 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week5Dates)

            into_week6_tab = 'INSERT INTO %s_06 (HouseID,Data,Date,Hour,Minute) \
            SELECT A.HouseID, A.Data, A.Date, A.Hour, A.Minute \
            FROM %s.%s A \
            WHERE A.Date in %s' % (TN,'Total_Profile_Monthly',TN, week6Dates)

            cur.execute(into_week1_tab)
            cur.execute(into_week2_tab)
            cur.execute(into_week3_tab)
            cur.execute(into_week4_tab)
            cur.execute(into_week5_tab)
            cur.execute(into_week6_tab)


