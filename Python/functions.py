#!/usr/bin/python

from types import NoneType

def GetOccupancy(cursor,TableNumber):
    query2 = "Select hes.Occupancy \
    FROM hes_database.home_information hes \
    WHERE hes.HouseID = %s" % (TableNumber)
    cursor.execute(query2)
    Occupancy = int(cursor.fetchone()[0])

    return Occupancy

def GetInfoId1(cursor):
    IDs = []
    cursor.execute("Show Tables FROM Ten_Mins LIKE '%Id1'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def GetInfoId2(cursor):
    IDs = []
    cursor.execute("Show Tables FROM Ten_Mins LIKE '%Id2'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def GetInfoId3(cursor):
    IDs = []
    cursor.execute("Show Tables FROM Ten_Mins LIKE '%Id3'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def SumTriHourly(cursor,TableNumber):
    #PartOfDay partitioning day up into 8 sections, Section 1 contains hours 0,1,2 \
    # So on with the other sections
    temp1 = "Create table temp1 (Data int, Date Date, PartOfDay int)"
    cursor.execute(temp1)
    Section1 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '1' \
    From %s \
    Where Hour = 0 or Hour = 1 or Hour = 2" % (TableNumber)

    Section2 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '2' \
    From %s \
    Where Hour = 3 or Hour = 4 or Hour = 5" % (TableNumber)

    Section3 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '3' \
    From %s \
    Where Hour = 6 or Hour = 7 or Hour = 8" % (TableNumber)

    Section4 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '4' \
    From %s \
    Where Hour = 9 or Hour = 10 or Hour = 11" % (TableNumber)

    Section5 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '5' \
    From %s \
    Where Hour = 12 or Hour = 13 or Hour = 14" % (TableNumber)

    Section6 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '6' \
    From %s \
    Where Hour = 15 or Hour = 16 or Hour = 17" % (TableNumber)

    Section7 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '7' \
    From %s \
    Where Hour = 18 or Hour = 19 or Hour = 20" % (TableNumber)

    Section8 = "Insert into temp1 (Data,Date,PartOfDay) \
    SELECT Data, Date, '8' \
    From %s \
    Where Hour = 21 or Hour = 22 or Hour = 23" % (TableNumber)

    cursor.execute(Section1)
    cursor.execute(Section2)
    cursor.execute(Section3)
    cursor.execute(Section4)
    cursor.execute(Section5)
    cursor.execute(Section6)
    cursor.execute(Section7)
    cursor.execute(Section8)

    temp = "Create table temp(Data int, Date Date, SectionOfDay int)"
    cursor.execute(temp)
    query = "INSERT INTO temp (Data,Date,SectionOfDay) \
    SELECT sum(Data), Date, PartOfDay \
    FROM temp1 \
    group by Date, PartOfDay"
    cursor.execute(query)

    cursor.execute("drop table temp1")


def SumHourly(cursor,TableNumber):
    temp = "Create table temp (Data int, Date Date, Hour int)"
    cursor.execute(temp)
    query = "INSERT INTO temp (Data, Date, Hour) \
     Select sum(Data), Date, Hour \
     from %s \
     group by Date, Hour" % (TableNumber)
    cursor.execute(query)

def SumDaily(cursor,TableNumber):
    temp = "Create table temp (Data int,Date Date)"
    cursor.execute(temp)
    query = "INSERT INTO temp (Data,Date) \
    SELECT sum(Data), Date \
    FROM %s \
    GROUP BY Date" % (TableNumber)
    cursor.execute(query)

def SumHalfHourly(cursor,TableNumber):
    temp = "Create table temp (Data int, Date Date, Hour int, Minute int)"
    cursor.execute(temp)
    query = "INSERT INTO temp (Data,Date,Hour, Minute) \
    SELECT SUM(Data), Date, Hour, MIN(Minute) \
    FROM %s \
    GROUP BY Date, Hour, FLOOR(Minute/30) " % (TableNumber)
    cursor.execute(query)

def GetHouseIDs(cursor):
    HouseIds = []
    cursor.execute("Select Distinct Household from hes_database.appliance_group_data")
    HouseNumbers = cursor.fetchall()
    for row in HouseNumbers:
        HouseNumber1 = row["Household"]
        HouseIds.append(HouseNumber1)
    return HouseIds





def GetHouseDbsIDs(cursor):
    HouseNumbersDbs = []
    cursor.execute("Select Distinct Household from hes_database.appliance_group_data limit 1")
    HouseNumbers = cursor.fetchall()
    for row in HouseNumbers:
        HouseNumber1 = row["Household"]
        HouseNumber3 = 'n' + HouseNumber1
        HouseNumbersDbs.append(HouseNumber3)
    return HouseNumbersDbs


def AvgPerHour(cursor,Table,HouseNumber):
    AvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourly.append(HouseNumber)
    Hours = range(0,24)
    for hour in Hours:

        """query = "select sum(Data)/count(distinct Date) as Average \
        from %s where Hour = %s" % (Table,hour)"""
        query = "SELECT avg(Data) as Average \
        from %s where Hour = %s" % (Table, hour)
        cursor.execute(query)
        av = cursor.fetchone()
        av = av[0]
        av = float(av)
        AvgHourly.append([hour,av])
    return AvgHourly

def StdAvgPerHour(cursor,Table,HouseNumber):
    StdvAvgHourly = []
    HouseNumber = HouseNumber[0].split('_')[0]
    StdvAvgHourly.append(HouseNumber)
    Hours = range(0,24)
    for hour in Hours:


        query = "SELECT avg(Data) as Average, std(Data) as Stdv \
        from %s where Hour = %s" % (Table, hour)
        cursor.execute(query)
        av,stdv = cursor.fetchone()
        av = float(av)
        stdv = float(stdv)


        StdvAvgHourly.append([hour,av,stdv])
    return StdvAvgHourly

def AvgPerDay(cursor,Table,HouseNumber):
    AvgDaily = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgDaily.append(HouseNumber)

    Day_of_the_week = "date_format(Date, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        query = "select AVG(Data) as AvgDay \
        from %s where %s = %s" % (Table,Day_of_the_week, day)
        cursor.execute(query)
        apd = cursor.fetchone()
        apd = apd[0]
        if apd is None:
            apd = 0
        else:
            apd = float(apd)
        AvgDaily.append([day,apd])
    return AvgDaily

def StdAvgPerDay(cursor,Table,HouseNumber):
    AvgDaily = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgDaily.append(HouseNumber)

    Day_of_the_week = "date_format(Date, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        query = "select AVG(Data) as AvgDay, STD(Data) as Stdv \
        from %s where %s = %s" % (Table,Day_of_the_week, day)
        cursor.execute(query)
        apd, std = cursor.fetchone()
        if apd is None:
            apd = 0
        else:
            apd = float(apd)

        if std is None:
            std = 0
        else:
            std = float(std)
        AvgDaily.append([day,apd,std])
    return AvgDaily


def AvgPerHourDay(cursor,Table,HouseNumber):
    AvgHourDaily = []
    HouseNumber = HouseNumber[0].split('_')[0]
    AvgHourDaily.append(HouseNumber)
    Hours = range(0,24)
    Day_of_the_week = "date_format(Date, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        for hour in Hours:
            query = "select AVG(Data) as AvgHourDay \
            from %s where Hour = %s and %s = %s GROUP BY HOUR" % (Table,hour, Day_of_the_week, day)
            cursor.execute(query)
            avd = cursor.fetchone()
            if avd is None:
                avd = 0
            else:
                avd = float(avd[0])
            AvgHourDaily.append([day,hour,avd])
    return AvgHourDaily

def StdAvgPerHourDay(cursor,Table,HouseNumber):
    StdAvgHourDaily = []
    HouseNumber = HouseNumber[0].split('_')[0]
    StdAvgHourDaily.append(HouseNumber)
    Hours = range(0,24)
    Day_of_the_week = "date_format(Date, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        for hour in Hours:
            query = "select AVG(Data) as AvgHourDay, STD(Data) as StdHourDay \
            from %s where Hour = %s and %s = %s GROUP BY HOUR" % (Table,hour, Day_of_the_week, day)
            cursor.execute(query)

            thing = cursor.fetchone()
            if thing is None:
                avd = 0
                std = 0
            else:
                avd = float(thing[0])
                std = float(thing[1])

            StdAvgHourDaily.append([day,hour,avd,std])
    return StdAvgHourDaily


