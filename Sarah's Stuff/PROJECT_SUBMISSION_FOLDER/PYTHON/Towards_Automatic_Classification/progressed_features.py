#!/usr/bin/python

import MySQLdb as mdb
import numpy as np

from types import *


from functions import *
from recreated_features_functions import *
from Progressed_Functions import *
import arff
import csv

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
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

    # need 48 titles for each these groups
    names_alldays = []
    names_weekdays = []
    names_weekends = []
    names_maxs = []
    names_mins = []
    names_svariance = []


    for i in range (0,24):
        for j in [11,30]:
            d = 'alldays%s%s' % (i,j)
            names_alldays.append(d)

            e = 'weekdays%s%s' % (i,j)
            names_weekdays.append(e)

            f = 'weekends%s%s' % (i,j)
            names_weekends.append(f)

            g = 'maxs%s%s' % (i,j)
            names_maxs.append(g)

            h = 'mins%s%s' % (i,j)
            names_mins.append(h)

            k = 'vars%s%s' % (i,j)
            names_svariance.append(k)

    # need 8 titles for each of these groups
    names_evenings = []
    names_mornings = []
    names_nights = []
    names_noons = []
    names_morningNoon = []
    names_eveningNoon = []


    for i in range (0,9):
        d = 'evenings%s' % (i)
        names_evenings.append(d)

        e = 'mornings%s' % (i)
        names_mornings.append(e)

        f = 'nights%s' % (i)
        names_nights.append(f)

        g = 'morningNoon%s' % (i)
        names_morningNoon.append(g)

        h = 'eveningNoon%s' % (i)
        names_eveningNoon.append(h)

        k = 'noons%s' % (i)
        names_noons.append(k)

    names_sxcorr = ['MonTue_corr', 'TueWed_corr', 'WedThur_corr', 'ThurFri_corr', \
                   'FriSat_corr', 'SatSun_corr', 'SunMon_corr']

    column_names = names_alldays + names_weekdays + names_weekends + names_evenings + \
    names_mornings + names_nights +names_noons + names_maxs + names_mins + \
    ['The_mean' , 'The_max' , 'The_min' , 'The_std' , 'The_mornings' , 'The_noons' , \
    'The_eveings' , 'The_nights' , 'The_days' , \
    'r_meanMax' , 'r_minMean' ] +  names_morningNoon + names_eveningNoon + ['Night/Day' , \
    'Morning/Noon' , 'Evening/Noon' , \
    't_day_max' , 't_above_mean' , 't_above_1kw' , 't_above_2kw' ] + \
    names_svariance + names_sxcorr + ['s_num_peaks' , 'single_variance' , 's_diff'] + \
     ['occupants']



    """column_names =['c_day','c_weekday', 'c_weekend','c_evening','c_morning', 'c_night', 'c_noon', 'c_max', 'c_min', 'c_mean', \
                   'r_meanMax','r_minMean', 'r_nightDay', 'r_morningNoon','r_eveningNoon', \
                   't_above_1kw', 't_above_2kw', 't_day_max','t_above_mean', \
                   's_variance', 's_diff', 'MonTue_corr', 'TueWed_corr', 'WedThur_corr', 'ThurFri_corr', \
                   'FriSat_corr', 'SatSun_corr', 'SunMon_corr', 's_num_peaks', 'occupants' ]"""
##########################################################################################################
    #Consumption figures
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

    # Extra added single values
    The_mean= []
    The_max = []
    The_min = []
    The_std = []
    The_days = []
    The_nights = []
    The_mornings= []
    The_noons = []
    The_evenings = []


    #Ratios
    R_meanMax   =   []
    R_minMean   =   []
    R_nightDay  =   []
    R_morningNoon=  []
    R_eveningNoon=  []
    # Single Valued ratios
    NightDays = []
    MorningNoons = []
    EveningNoons = []

    # Temporal properties
    T_above_1kw =   []
    T_above_2kw =   []
    T_daily_max =   []
    T_above_mean=   []

    # Statistical Properties
    S_variance  =   []
    S_diff      =   []
    S_x_corr    =   []
    S_num_peaks =   []

    # single variance value
    Single_variance = []


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

############### Consumption Figures ###############

        Avg = AvgPerHalfHour(cur,'temp',TN)
        C_days.append(Avg[1:])

        AvgWeekdays = AvgPerHalfHourWeekdays(cur,'temp',TN)
        C_weekday.append(AvgWeekdays[1:])

        AvgWeekends = AvgPerHalfHourWeekends(cur,'temp',TN)
        C_weekend.append(AvgWeekends[1:])

        AvgEvenings = AvgPerHalfHourEvenings(cur,'temp',TN)
        C_evening.append(AvgEvenings[1:])

        AvgMornings = AvgPerHalfHourMornings(cur,'temp',TN)
        C_morning.append(AvgMornings[1:])

        AvgNights = AvgPerHalfHourNights(cur,'temp',TN)
        C_night.append(AvgNights[1:])

        AvgNoons = AvgPerHalfHourNoons(cur,'temp',TN)
        C_noon.append(AvgNoons[1:])

        Max = MaxPerHalfHour(cur,'temp',TN)
        C_max.append(Max[1:])

        Min = MinPerHalfHour(cur,'temp',TN)
        C_min.append(Min[1:])


        # The single values of max, min , mean, standard deviation, day,night,morning,noon,evening
        Mean = theMean(cur,'temp',TN)
        The_mean.append(Mean[1:])

        mMax = theMax(cur,'temp',TN)
        The_max.append(mMax[1:])

        mMin = theMin(cur,'temp',TN)
        The_min.append(mMin[1:])

        std = theStd(cur,'temp',TN)
        The_std.append(std[1:])

        theDay = Pdaily(cur,'temp',TN)
        The_days.append([theDay[1][0]])

        theNight = PNight(cur,'temp',TN)
        The_nights.append([theNight[1][0]])

        theMorning = PMorning(cur,'temp',TN)
        The_mornings.append([theMorning[1][0]])

        theNoon = PNoon(cur,'temp',TN)
        The_noons.append([theNoon[1][0]])

        theEvening = PEvenings(cur,'temp',TN)
        The_evenings.append([theEvening[1][0]])

################## Ratios ###########

        if mMax[1] == 0:
            mMax[1] = 1

        r_meanMax = Mean[1]/mMax[1]
        R_meanMax.append([r_meanMax])

        if Mean[1] == 0:
            Mean[1] = 1

        r_minMean = mMin[1]/Mean[1]
        R_minMean.append([r_minMean])

        # Make sure not dividing by zero
        for i in range(1,len(AvgNoons)):
            if AvgNoons[i] == 0:
                AvgNoons[i] = 1

        r_morningNoon = []

        for i in range(1,len(AvgNoons)):
            r_mornNoon = AvgMornings[i]/AvgNoons[i]
            r_morningNoon.append(r_mornNoon)
        R_morningNoon.append(r_morningNoon)

        r_eveningNoon = []

        for i in range(1,len(AvgNoons)):
            r_eveNoon = AvgEvenings[i]/AvgNoons[i]
            r_eveningNoon.append(r_eveNoon)
        R_eveningNoon.append(r_eveningNoon)

        ## The single valued ratios

        if theDay[1][0] == 0:
            theDay[1][0] = 1

        if theNoon[1][0] == 0:
            theNoon[1][0] = 1

        NightDay = theNight[1][0]/theDay[1][0]
        NightDays.append([NightDay])

        MorningNoon = theMorning[1][0]/theNoon[1][0]
        MorningNoons.append([MorningNoon])

        EveningNoon = theEvening[1][0]/theNoon[1][0]
        EveningNoons.append([EveningNoon])




################### Temporal Properties ##############

        TDMAX = TDmax(cur,'temp', TN)
        tdmax = []
        tdmax.append(TDMAX[1][0])
        T_daily_max.append(tdmax)


        TAbove = TaboveMean(cur,'temp',TN, Mean[1])
        times =  len(TAbove) -1
        number_of_hours = times/2.0
        T_above_mean.append([number_of_hours])

        T1kw = Tabove1kwHalfHour(cur,'temp',TN)
        T_above_1kw.append([T1kw[1]])

        T2kw = Tabove2kwHalfHour(cur,'temp',TN)
        T_above_2kw.append([T2kw[1]])




################################### STATISTICAL PROPERTIES #######################################################
        Var = VarPerHalfHour(cur,'temp',TN)
        S_variance.append(Var[1:])

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

        # Single value for varience
        svar = Svariance(cur,'temp', TN)
        s_var = []
        s_var.append(svar[1][0])
        Single_variance.append(s_var)

###################### OCCUPANCY ############################
        occupancy = GetOccupancy(cur,HN)

        # for binary classes, lots vs few people in household
        if occupancy > 3:
            occupancy = 1
        else:
            occupancy = 0
        Occupants.append([occupancy])

        cur.execute("drop table if exists temp")

    data = zip(C_days,C_weekday,C_weekend,C_evening,C_morning,C_night,C_noon,C_max,C_min, \
    The_mean,The_max,The_min,The_std,The_mornings,The_noons, The_evenings,The_nights,The_days, \
                R_meanMax,R_minMean,R_morningNoon, R_eveningNoon, \
                NightDays,MorningNoons,EveningNoons, \
                 T_daily_max,T_above_mean, T_above_1kw,T_above_2kw, \
                  S_variance,S_x_corr,S_num_peaks,Single_variance,S_diff, Occupants )

    data5 = []
    for i in range(len(data)):
        h = ()
        for j in range(len(data[i])):
            h = h + tuple(data[i][j],)
        data5.append(h)

    out = csv.writer(open("BINARY_Recreated_Week_Progressed_HalfHour.csv","w"), delimiter = ',')
    out.writerow(column_names)
    for i in range(0,len(data5)):
        ToBePrinted = list(data5[i])
        out.writerow(ToBePrinted)

    arff.dump('BINARY_Recreated_Week_progressed_halfhourly.arff',data5, relation='BINARY_Recreated_Week_progressed_HalfHour', \
               names = column_names)
    """print arff.dump('BINARY_Recreated_Week_progressed_halfhourly.arff',data5, relation='BINARY_Recreated_Week_progressed_HalfHour', \
               names = ['alldays00', 'alldays030', 'alldays10', 'alldays130', 'alldays20', 'alldays230', 'alldays30', \
                         'alldays330', 'alldays40', 'alldays430', 'alldays50', 'alldays530', 'alldays60', 'alldays630', \
                          'alldays70', 'alldays730', 'alldays80', 'alldays830', 'alldays90', 'alldays930', 'alldays100', \
                           'alldays1030', 'alldays110', 'alldays1130', 'alldays120', 'alldays1230', 'alldays130', \
                            'alldays1330', 'alldays140', 'alldays1430', 'alldays150', 'alldays1530', 'alldays160', \
                             'alldays1630', 'alldays170', 'alldays1730', 'alldays180', 'alldays1830', 'alldays190', \
                              'alldays1930', 'alldays200', 'alldays2030', 'alldays210', 'alldays2130', 'alldays220', \
                               'alldays2230', 'alldays230', 'alldays2330', 'weekdays00', 'weekdays030', 'weekdays10', \
                                'weekdays130', 'weekdays20', 'weekdays230', 'weekdays30', 'weekdays330', 'weekdays40', \
                                'weekdays430', 'weekdays50', 'weekdays530', 'weekdays60', 'weekdays630', 'weekdays70', \
                                 'weekdays730', 'weekdays80', 'weekdays830', 'weekdays90', 'weekdays930', 'weekdays100', \
                                  'weekdays1030', 'weekdays110', 'weekdays1130', 'weekdays120', 'weekdays1230', 'weekdays130', \
                                   'weekdays1330', 'weekdays140', 'weekdays1430', 'weekdays150', 'weekdays1530', 'weekdays160', \
                                    'weekdays1630', 'weekdays170', 'weekdays1730', 'weekdays180', 'weekdays1830', 'weekdays190', \
                                     'weekdays1930', 'weekdays200', 'weekdays2030', 'weekdays210', 'weekdays2130', 'weekdays220', \
                                      'weekdays2230', 'weekdays230', 'weekdays2330', 'weekends00', 'weekends030', 'weekends10', \
                                       'weekends130', 'weekends20', 'weekends230', 'weekends30', 'weekends330', 'weekends40', 'weekends430', \
                                        'weekends50', 'weekends530', 'weekends60', 'weekends630', 'weekends70', 'weekends730', 'weekends80', \
                                         'weekends830', 'weekends90', 'weekends930', 'weekends100', 'weekends1030', 'weekends110', 'weekends1130', \
                                          'weekends120', 'weekends1230', 'weekends130', 'weekends1330', 'weekends140', 'weekends1430', 'weekends150', \
                                           'weekends1530', 'weekends160', 'weekends1630', 'weekends170', 'weekends1730', 'weekends180', 'weekends1830', \
                                            'weekends190', 'weekends1930', 'weekends200', 'weekends2030', 'weekends210', 'weekends2130', 'weekends220', \
                                            'weekends2230', 'weekends230', 'weekends2330', 'evenings0', 'evenings1', 'evenings2', 'evenings3', 'evenings4', \
                                             'evenings5', 'evenings6', 'evenings7', 'evenings8', 'mornings0', 'mornings1', 'mornings2', 'mornings3', 'mornings4', \
        'mornings5', 'mornings6', 'mornings7', 'mornings8', 'nights0', 'nights1', \
         'nights2', 'nights3', 'nights4', 'nights5', 'nights6', 'nights7', 'nights8', 'noons0', \
         'noons1', 'noons2', 'noons3', 'noons4', 'noons5', 'noons6', 'noons7', 'noons8', 'maxs00', \
          'maxs030', 'maxs10', 'maxs130', 'maxs20', 'maxs230', 'maxs30', 'maxs330', 'maxs40', 'maxs430', \
           'maxs50', 'maxs530', 'maxs60', 'maxs630', 'maxs70', 'maxs730', 'maxs80', 'maxs830', 'maxs90', \
            'maxs930', 'maxs100', 'maxs1030', 'maxs110', 'maxs1130', 'maxs120', 'maxs1230', 'maxs130', \
             'maxs1330', 'maxs140', 'maxs1430', 'maxs150', 'maxs1530', 'maxs160', 'maxs1630', 'maxs170', \
              'maxs1730', 'maxs180', 'maxs1830', 'maxs190', 'maxs1930', 'maxs200', 'maxs2030', 'maxs210', \
               'maxs2130', 'maxs220', 'maxs2230', 'maxs230', 'maxs2330', 'mins00', 'mins030', 'mins10', \
                'mins130', 'mins20', 'mins230', 'mins30', 'mins330', 'mins40', 'mins430', 'mins50', 'mins530', \
                 'mins60', 'mins630', 'mins70', 'mins730', 'mins80', 'mins830', 'mins90', 'mins930', 'mins100', \
                  'mins1030', 'mins110', 'mins1130', 'mins120', 'mins1230', 'mins130', 'mins1330', 'mins140', \
                   'mins1430', 'mins150', 'mins1530', 'mins160', 'mins1630', 'mins170', 'mins1730', 'mins180', \
                    'mins1830', 'mins190', 'mins1930', 'mins200', 'mins2030', 'mins210', 'mins2130', 'mins220', \
                     'mins2230', 'mins230', 'mins2330', 'The_mean', 'The_max', 'The_min', 'The_std', 'The_mornings', \
                      'The_noons', 'The_eveings', 'The_nights', 'The_days', 'r_meanMax', 'r_minMean', 'morningNoon0',  \
                      'morningNoon1', 'morningNoon2', 'morningNoon3', 'morningNoon4', 'morningNoon5', 'morningNoon6', \
     'morningNoon7', 'morningNoon8', 'eveningNoon0', 'eveningNoon1', 'eveningNoon2', 'eveningNoon3', \
     'eveningNoon4', 'eveningNoon5', 'eveningNoon6', 'eveningNoon7', 'eveningNoon8', 'Night/Day', \
 'Morning/Noon', 'Evening/Noon', 't_day_max', 't_above_mean', 't_above_1kw', 't_above_2kw', \
   'vars00', 'vars030', 'vars10', 'vars130', 'vars20', 'vars230', 'vars30', 'vars330', 'vars40', \
    'vars430', 'vars50', 'vars530', 'vars60', 'vars630', 'vars70', 'vars730', 'vars80', 'vars830', \
   'vars90', 'vars930', 'vars100', 'vars1030', 'vars110', 'vars1130', 'vars120', 'vars1230', 'vars130', \
     'vars1330', 'vars140', 'vars1430', 'vars150', 'vars1530', 'vars160', 'vars1630', 'vars170', 'vars1730', \
      'vars180', 'vars1830', 'vars190', 'vars1930', 'vars200', 'vars2030', 'vars210', 'vars2130', 'vars220', \
       'vars2230', 'vars230', 'vars2330', 'MonTue_corr', 'TueWed_corr', 'WedThur_corr', 'ThurFri_corr', 'FriSat_corr', \
        'SatSun_corr', 'SunMon_corr', 's_num_peaks', 'single_variance', 's_diff', 'occupants'])"""