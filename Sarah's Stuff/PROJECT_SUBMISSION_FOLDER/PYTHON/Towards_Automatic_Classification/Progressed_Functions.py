#!/usr/bin/python
import numpy as np

from types import NoneType

def theMean(cursor,Table,HouseNumber):
    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)


    query = "SELECT avg(Data) as Average \
    from %s " % (Table)
    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append(av)
    return Avg

def theMax(cursor,Table,HouseNumber):
    maxs = []
    HouseNumber = HouseNumber[0].split('_')[0]
    maxs.append(HouseNumber)


    query = "SELECT MAX(Data) as Average \
    from %s " % (Table)
    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    maxs.append(av)
    return maxs

def theMin(cursor,Table,HouseNumber):
    mins = []
    HouseNumber = HouseNumber[0].split('_')[0]
    mins.append(HouseNumber)


    query = "SELECT MIN(Data) as Average \
    from %s " % (Table)
    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    mins.append(av)
    return mins

def theStd(cursor,Table,HouseNumber):
    std = []
    HouseNumber = HouseNumber[0].split('_')[0]
    std.append(HouseNumber)


    query = "SELECT STD(Data) as Average \
    from %s " % (Table)
    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    std.append(av)
    return std

def GetInfoId1(cursor):
    IDs = []
    cursor.execute("Show Tables FROM House_Sets LIKE '%Id1'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def AvgPerHalfHour(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = range(0,24)
    Minutes = [0,30]
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def VarPerHalfHour(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(0,24))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT STD(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            av = av*av
            AvgHourly.append(av)
    return AvgHourly

def AvgPerHalfHourWeekdays(cursor,Table,HouseNumber):

    Day_of_the_week = "date_format(Date, '%W')"
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(0,24))
    Minutes = (0,30)
    Weekdays = ('Monday','Tuesday','Wednesday','Thursday','Friday')


    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s AND %s in %s" % (Table, hour, minute, Day_of_the_week, Weekdays)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def AvgPerHalfHourWeekends(cursor,Table,HouseNumber):

    Day_of_the_week = "date_format(Date, '%W')"
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(0,24))
    Minutes = (0,30)
    Weekdays = ('Saturday','Sunday')


    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s AND %s in %s" % (Table, hour, minute, Day_of_the_week, Weekdays)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly


def AvgPerHalfHourEvenings(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(18,22))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def AvgPerHalfHourMornings(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(06,10))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def AvgPerHalfHourNights(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(01,05))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def AvgPerHalfHourNoons(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = tuple(range(10,14))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT avg(Data) as Average \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            av = cursor.fetchone()
            av = av[0]
            av = float(av)
            AvgHourly.append(av)
    return AvgHourly

def MaxPerHalfHour(cursor,Table,HouseNumber):
    MaxHalfHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    MaxHalfHourly.append(HouseNumber)
    Hours = tuple(range(0,24))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT MAX(Data) as Maximum \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            mx = cursor.fetchone()
            mx = mx[0]
            mx = float(mx)
            MaxHalfHourly.append(mx)
    return MaxHalfHourly

def MinPerHalfHour(cursor,Table,HouseNumber):
    MinHalfHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    MinHalfHourly.append(HouseNumber)
    Hours = tuple(range(0,24))
    Minutes = (0,30)
    for hour in Hours:
        for minute in Minutes:

            query = "SELECT MIN(Data) as Maximum \
            from %s where Hour = %s AND Minute = %s " % (Table, hour, minute)
            cursor.execute(query)
            mn = cursor.fetchone()
            mn = mn[0]
            mn = float(mn)
            MinHalfHourly.append(mn)
    return MinHalfHourly
