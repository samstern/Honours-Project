#!/usr/bin/python

import MySQLdb as mdb
import numpy as np


from recreated_features_functions import *
from functions import *
import arff
import csv

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly');
with con:

# The features:
# Originaly done in half hour readings over a one week

# let P denote the 30-minute mean power samples provided by the data set
##########################################################################################################
### Consumption figures ###
# P(daily)                            -- c_day
# P(daily, weekdays only)             -- c_weekday
# P(daily, weekend only)              -- c_weekend
# P for (6 pm - 10 pm)                -- c_evening
# P for (6 am - 10 am)                -- c_morning
# P for (1 am - 5  am)                -- c_night
# P for (10am - 2  pm)                -- c_noon
# Maximum of P                        -- c_max
# Minimum of P                        -- c_min

##########################################################################################################
### Ratios ###
# Mean P over max P                    --- r_mean/max
# Minimum P over mean P                --- r_min/mean
# c_night / c_day                      --- r_night/day
# c_morning / c_noon                   --- r_morning/noon
# c_evening / c_noon                   --- r_evening/noon

##########################################################################################################
### Temporal properties ###
# First Time P > 1kW                    -- t_above_1kw
# First Time P > 2kW                    -- t_above_2kw
# First Time P reaches maximum          -- t_daily_max
# Period for which P > mean             -- t_above_mean

##########################################################################################################
### Statistical Properties ###
# Variance                              -- s_variance
# Sigma (| P(t) - P(t-1)|) for all t    -- s-diff
# Cross-correlation of subsequent days  -- s_x-corr
# #P with (P(t) - P(t+-1 > 0.2 kW)      -- s_num_peaks

##########################################################################################################
### Normalisation ###
# Unit variance scaling method

##########################################################################################################
##### column names #####

    column_names =['c_day','c_weekday', 'c_weekend','c_evening','c_morning', 'c_night', 'c_noon', 'c_max', 'c_min', 'c_mean', \
                   'r_meanMax','r_minMean', 'r_nightDay', 'r_morningNoon','r_eveningNoon', \
                   't_above_1kw', 't_above_2kw', 't_day_max','t_above_mean', \
                   's_variance', 's_diff', 'MonTue_corr', 'TueWed_corr', 'WedThur_corr', 'ThurFri_corr', \
                   'FriSat_corr', 'SatSun_corr', 'SunMon_corr', 's_num_peaks', 'occupants' ]
##########################################################################################################

    C_days      =   []
    C_weekday   =   []
    C_weekend   =   []
    C_evening   =   []
    C_morning   =   []
    C_night     =   []
    C_noon      =   []
    C_max       =   []
    C_min       =   []
    C_mean      =   []

    R_meanMax   =   []
    R_minMean   =   []
    R_nightDay  =   []
    R_morningNoon=  []
    R_eveningNoon=  []


    T_above_1kw =   []
    T_above_2kw =   []
    T_daily_max =   []
    T_above_mean=   []

    S_variance  =   []
    S_diff      =   []
    S_x_corr    =   []
    S_num_peaks =   []


    StandardDev = []
    Days = []
    Occupants = []

    cur = con.cursor()
    cur.execute("drop table if exists temp")

    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cur)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])


    cur.execute("Show tables")
    all_tables = cur.fetchall()
    for TN in all_tables:
        HN = TN[0].split('_')[0]

        # Working in 30-minute readings
        SumHalfHourly(cur,TN)

        # Working in Hour readings
        #SumHourly(cur,TN)

############### Consumption Figures ###############

        daily = Pdaily(cur,'temp', TN)
        c_day = []
        c_day.append(daily[1][0])
        C_days.append(c_day)


        weekdy = PdailyWeekday(cur,'temp', TN)
        c_weekday = []
        c_weekday.append(weekdy[1][0])
        C_weekday.append(c_weekday)

        weeknd = PdailyWeekday(cur,'temp', TN)
        c_weekend = []
        c_weekend.append(weeknd[1][0])
        C_weekend.append(c_weekend)

        evening = PEvenings(cur,'temp', TN)
        c_evening = []
        c_evening.append(evening[1][0])
        C_evening.append(c_evening)

        morning = PMorning(cur,'temp', TN)
        c_morning = []
        c_morning.append(morning[1][0])
        C_morning.append(c_morning)

        night = PNight(cur,'temp', TN)
        c_night = []
        c_night.append(night[1][0])
        C_night.append(c_night)

        noon = PNight(cur,'temp', TN)
        c_noon = []
        c_noon.append(noon[1][0])
        C_noon.append(c_noon)

        c_max = max(c_day, c_weekday, c_weekend, c_evening, c_morning, c_noon,c_night)
        C_max.append(c_max)

        c_min = min(c_day, c_weekday, c_weekend, c_evening, c_morning, c_noon, c_night)
        C_min.append(c_min)

        c_mean = [((c_day[0]) + (c_weekday[0]) + (c_weekend[0]) + (c_evening[0]) + (c_morning[0]) + (c_noon[0]) + (c_night[0]))/7]
        C_mean.append(c_mean)

################## Ratios ###########

        if c_max[0] == 0:
            c_max[0] = 1

        r_meanMax = c_mean[0]/c_max[0]
        R_meanMax.append([r_meanMax])

        if c_mean[0] == 0:
            c_mean[0] = 1

        r_minMean = c_min[0]/c_mean[0]
        R_minMean.append([r_minMean])

        if c_day[0] == 0:
            c_day[0] = 1

        r_nightDay = [c_night[0]/c_day[0]]
        R_nightDay.append(r_nightDay)

        if c_noon[0] == 0:
            c_noon[0] = 1

        r_morningNoon = [c_morning[0]/c_noon[0]]
        R_morningNoon.append(r_morningNoon)

        r_eveningNoon = [c_evening[0]/c_noon[0]]
        R_eveningNoon.append(r_eveningNoon)



################### Temporal Properties ##############

        TDMAX = TDmax(cur,'temp', TN)
        tdmax = []
        tdmax.append(TDMAX[1][0])
        T_daily_max.append(tdmax)



        TAbove = TaboveMean(cur,'temp',TN, c_mean[0])
        times =  len(TAbove) -1
        number_of_hours = times/2.0
        T_above_mean.append([number_of_hours])

        T1kw = Tabove1kwHalfHour(cur,'temp',TN)
        #print T1kw[1:]
        T_above_1kw.append([T1kw[1]])

        T2kw = Tabove2kwHalfHour(cur,'temp',TN)
        T_above_2kw.append([T2kw[1]])


################### Statistical Properties ##############
        svar = Svariance(cur,'temp', TN)
        s_var = []
        s_var.append(svar[1][0])
        S_variance.append(s_var)

        s_x_corr = S_X_Corr(cur,'temp',TN)
        s_corr = []
        for i in range(0,len(s_x_corr)):
            s_x = s_x_corr[i][0]
            s_corr.append(s_x)
        S_x_corr.append(s_corr)

        s_difference = SDifference(cur,'temp',TN)
        S_diff.append([s_difference[1]])


        speaks = SPeaks(cur,'temp',TN)
        S_num_peaks.append(speaks)

###################### OCCUPANCY ############################
        occupancy = GetOccupancy(cur,HN)
        """if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0"""
        Occupants.append([occupancy])


        cur.execute("drop table if exists temp")

    #print 'Max c_day', max(C_days)
    #print T_daily_max[0:5]
    #print T_above_mean[0:5]
    #print T_above_1kw[:5]
    #print T_above_2kw[:5]
    #print S_variance
    #print S_diff
    #print 'S_num_peaks', S_num_peaks
    data = zip(C_days,C_weekday,C_weekend,C_evening,C_morning,C_night,C_noon,C_max,C_min,C_mean, \
                R_meanMax,R_minMean,R_nightDay,R_morningNoon, R_eveningNoon, \
                 T_above_1kw,T_above_2kw,T_daily_max,T_above_mean, \
                  S_variance,S_diff,S_x_corr,S_num_peaks, Occupants )

    data5 = []
    for i in range(len(data)):
        h = ()
        for j in range(len(data[i])):
            h = h + tuple(data[i][j],)
        data5.append(h)

    out = csv.writer(open("Recreated_Month_Simple_Half_Hour.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data5)):
        ToBePrinted = list(data5[i])
        out.writerow(ToBePrinted)

    arff.dump('Recreated_Month_simple_Half_Hour.arff',data5, relation='Recreated_Month_Simple_Half_Hour', \
               names = ['c_day','c_weekday', 'c_weekend','c_evening','c_morning', 'c_night', 'c_noon', 'c_max', 'c_min', 'c_mean', \
                   'r_meanMax','r_minMean', 'r_nightDay', 'r_morningNoon','r_eveningNoon', \
                   't_above_1kw', 't_above_2kw', 't_day_max','t_above_mean', \
                   's_variance', 's_diff', 'MonTue_corr', 'TueWed_corr', 'WedThur_corr', 'ThurFri_corr', \
                   'FriSat_corr', 'SatSun_corr', 'SunMon_corr', 's_num_peaks', 'occupants'])

