#!/usr/bin/python
def GetInfoId2(cursor):
    IDs = []
    cursor.execute("Show Tables LIKE '%Id2'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def SumHourly(cursor,TableNumber):
    temp = "Create table temp (Data int, Date Date, Hour int)"
    cursor.execute(temp)
    query = "INSERT INTO temp (Data, Date, Hour) \
     Select sum(Data), Date, Hour \
     from %s \
     group by Date, Hour" % (TableNumber)
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


def AvgPerHour(cursor,HouseNum):
    AvgHourly = []
    nums = HouseNum.split('n')
    num = nums[1]
    AvgHourly.append(num)
    Hours = range(0,24)
    for hour in Hours:

        query = "select sum(Data)/count(distinct Dates) as Average \
        from %s where Hour = %s" % (HouseNum, hour)
        cursor.execute(query)
        av = cursor.fetchone()
        av = av["Average"]
        av = float(av)
        AvgHourly.append([hour,av])
    return AvgHourly

def AvgPerDay(cursor,HouseNum):
    AvgDaily = []
    nums = HouseNum.split('n')
    num = nums[1]
    AvgDaily.append(num)

    Day_of_the_week = "date_format(Dates, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        query = "select AVG(Data) as AvgDay \
        from %s where %s = %s" % (HouseNum,Day_of_the_week, day)
        cursor.execute(query)
        apd = cursor.fetchone()
        apd = apd["AvgDay"]
        apd = float(apd)
        AvgDaily.append([day,apd])
    return AvgDaily


def AvgPerHourDay(cursor,HouseNum):
    AvgHourDaily = []
    nums = HouseNum.split('n')
    num = nums[1]
    AvgHourDaily.append(num)
    Hours = range(0,24)
    Day_of_the_week = "date_format(Dates, '%W')"
    Days = ["'Monday'", "'Tuesday'", "'Wednesday'", "'Thursday'", \
            "'Friday'", "'Saturday'", "'Sunday'"]
    for day in Days:
        for hour in Hours:
            query = "select AVG(Data) as AvgHourDay \
            from %s where Hour = %s and %s = %s" % (HouseNum, hour, Day_of_the_week, day)
            cursor.execute(query)
            avd = cursor.fetchone()
            avd = avd["AvgHourDay"]
            avd = float(avd)
            AvgHourDaily.append([day,hour,avd])
    return AvgHourDaily


