#!/usr/bin/python
import numpy as np

from types import NoneType

def GetInfoId1(cursor):
    IDs = []
    cursor.execute("Show Tables FROM House_Sets LIKE '%Id1'")
    tables = cursor.fetchall()
    for tab in tables:
        IDs.append(tab)
    return IDs

def Pdaily(cursor,Table, HouseNumber):
    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    query = "SELECT avg(Data) as Average \
    from %s" % (Table)
    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PdailyWeekday(cursor,Table,HouseNumber):

    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    Day_of_the_week = "date_format(Date, '%W')"
    WeekDays = ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday')

    query = "SELECT avg(Data) as Average \
    from %s where %s IN %s " % (Table, Day_of_the_week, WeekDays)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PdailyWeekend(cursor,Table,HouseNumber):

    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    Day_of_the_week = "date_format(Date, '%W')"
    WeekDays = ('Saturday','Sunday')

    query = "SELECT avg(Data) as Average \
    from %s where %s IN %s " % (Table, Day_of_the_week, WeekDays)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PEvenings(cursor,Table,HouseNumber):

    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    EveningHours = tuple(range(18,23))

    query = "SELECT avg(Data) as Average \
    from %s where Hour IN %s " % (Table, EveningHours)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PMorning(cursor,Table,HouseNumber):
    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    MorningHours = tuple(range(06,11))

    query = "SELECT avg(Data) as Average \
    from %s where Hour IN %s " % (Table, MorningHours)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PNight(cursor,Table,HouseNumber):
    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    NightHours = tuple(range(01,06))

    query = "SELECT avg(Data) as Average \
    from %s where Hour IN %s " % (Table, NightHours)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def PNoon(cursor,Table,HouseNumber):
    Avg = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Avg.append(HouseNumber)

    NoonHours = tuple(range(10,15))

    query = "SELECT avg(Data) as Average \
    from %s where Hour IN %s " % (Table, NoonHours)

    cursor.execute(query)
    av = cursor.fetchone()
    av = av[0]
    av = float(av)
    Avg.append([av])

    return Avg

def TDmax(cursor,Table,HouseNumber):
    TDmax = []
    HouseNumber = HouseNumber[0].split('_')[0]
    TDmax.append(HouseNumber)

    query = "SELECT Hour, Minute FROM %s \
    where Data = (SELECT MAX(Data) from %s)" % (Table, Table)

    cursor.execute(query)
    tdmax = cursor.fetchone()
    tdmax = str(tdmax[0]) + ':' + str(tdmax[1])
    TDmax.append([tdmax])

    return TDmax

def TDmaxHour(cursor,Table,HouseNumber):
    TDmax = []
    HouseNumber = HouseNumber[0].split('_')[0]
    TDmax.append(HouseNumber)

    query = "SELECT Hour FROM %s \
    where Data = (SELECT MAX(Data) from %s)" % (Table, Table)

    cursor.execute(query)
    tdmax = cursor.fetchone()
    tdmax = str(tdmax[0]) + ':' + '00'
    TDmax.append([tdmax])

    return TDmax

def TaboveMean(cursor, Table, HouseNumber, Mean):
    AllTimes = []

    HouseNumber = HouseNumber[0].split('_')[0]
    AllTimes.append(HouseNumber)

    query = "SELECT Hour, Minute FROM %s \
    WHERE Data > %s"  % (Table,Mean)

    cursor.execute(query)

    times = cursor.fetchall()
    for time in times:
        t1 = str(time[0]) + ':' + str(time[1])

        AllTimes.append(t1)
    return AllTimes

def TaboveMeanHour(cursor, Table, HouseNumber, Mean):
    AllTimes = []

    HouseNumber = HouseNumber[0].split('_')[0]
    AllTimes.append(HouseNumber)

    query = "SELECT Hour FROM %s \
    WHERE Data > %s"  % (Table,Mean)

    cursor.execute(query)

    times = cursor.fetchall()
    for time in times:
        t1 = str(time[0]) + ':' + '00'

        AllTimes.append(t1)
    return AllTimes

def Tabove1kwHalfHour(cursor,Table,HouseNumber):
    Time = []
    AllTimes = []
    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cursor)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])

    HouseNumber = HouseNumber[0].split('_')[0]
    Time.append(HouseNumber)

    # if Id = 1 -- *3.0 to get W
    # if Id = 3 -- *0.6 to get W

    if HouseNumber in HouseholdId1s:
        query = "SELECT Hour,Minute FROM %s \
        WHERE (Data*3) > 1000" % (Table)
    else:
        query = "SELECT Hour,Minute FROM %s \
        WHERE (Data*0.6) > 1000" % (Table)

    cursor.execute(query)

    times = cursor.fetchall()

    if len(times) == 0:
        minimum = 'none'
    else:
        for time in times:
            t1 = str(time[0]) + str(time[1])
            AllTimes.append(int(t1))

        if len(str(min(AllTimes))) == 2:
            minimum = '0' + str(min(AllTimes))[0] + ':' + str(min(AllTimes))[1] +'0'


        if len(str(min(AllTimes))) == 1:
            minimum = '0' + str(min(AllTimes))[0] + ':' + '00'


        if len(str(min(AllTimes))) == 4:
            minimum =  str(min(AllTimes))[0:2] + ':' + str(min(AllTimes))[2:]


        else:
            minimum = '0' + str(min(AllTimes))[0] + ':' + str(min(AllTimes))[1:]


    Time.append(minimum)
    return Time

def Tabove2kwHalfHour(cursor,Table,HouseNumber):
    Time = []
    AllTimes = []

    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cursor)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])

    HouseNumber = HouseNumber[0].split('_')[0]
    Time.append(HouseNumber)

    # if Id = 1 -- *3.0 to get W
    # if Id = 3 -- *0.6 to get W

    if HouseNumber in HouseholdId1s:
        query = "SELECT Hour,Minute FROM %s \
        WHERE (Data*3) > 2000" % (Table)
    else:
        query = "SELECT Hour,Minute FROM %s \
        WHERE (Data*0.6) > 2000" % (Table)

    cursor.execute(query)

    times = cursor.fetchall()

    if len(times) == 0:
        minimum = 'none'
    else:
        for time in times:
            t1 = str(time[0]) + str(time[1])
            AllTimes.append(int(t1))

        if len(str(min(AllTimes))) == 2:
            minimum = '0' + str(min(AllTimes))[0] + ':' + str(min(AllTimes))[1] +'0'


        if len(str(min(AllTimes))) == 1:
            minimum = '0' + str(min(AllTimes))[0] + ':' + '00'


        if len(str(min(AllTimes))) == 4:
            minimum =  str(min(AllTimes))[0:2] + ':' + str(min(AllTimes))[2:]


        else:
            minimum = '0' + str(min(AllTimes))[0] + ':' + str(min(AllTimes))[1:]


    Time.append(minimum)
    return Time


def Tabove1kwHour(cursor,Table,HouseNumber):
    Time = []
    AllTimes = []
    minn = []


    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cursor)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])

    HouseNumber = HouseNumber[0].split('_')[0]
    Time.append(HouseNumber)

    # if Id = 1 -- *3.0 to get W
    # if Id = 3 -- *0.6 to get W

    if HouseNumber in HouseholdId1s:
        query = "SELECT Hour FROM %s \
        WHERE (Data*3) > 1000" % (Table)
    else:
        query = "SELECT Hour FROM %s \
        WHERE (Data*0.6) > 1000" % (Table)

    cursor.execute(query)

    times = cursor.fetchall()
    for time in times:
        t1 = str(time[0])
        AllTimes.append(int(t1))
    if len(AllTimes) == 0:
        the_time = 'NONE'
    else:
        the_time = str(min(AllTimes))

    Time.append(the_time)

    return Time

def Tabove2kwHour(cursor,Table,HouseNumber):
    Time = []
    AllTimes = []
    minn = []


    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cursor)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])

    HouseNumber = HouseNumber[0].split('_')[0]
    Time.append(HouseNumber)

    # if Id = 1 -- *3.0 to get W
    # if Id = 3 -- *0.6 to get W

    if HouseNumber in HouseholdId1s:
        query = "SELECT Hour FROM %s \
        WHERE (Data*3) > 2000" % (Table)
    else:
        query = "SELECT Hour FROM %s \
        WHERE (Data*0.6) > 2000" % (Table)

    cursor.execute(query)

    times = cursor.fetchall()
    for time in times:
        t1 = str(time[0])
        AllTimes.append(int(t1))

    if len(AllTimes) == 0:
        the_time = 'NONE'
    else:
        the_time = str(min(AllTimes))

    Time.append(the_time)

    return Time

def Svariance(cursor,Table, HouseNumber):
    Var = []
    HouseNumber = HouseNumber[0].split('_')[0]
    Var.append(HouseNumber)

    query = "SELECT STD(Data) as StandardDeviation \
    from %s" % (Table)
    cursor.execute(query)
    std = cursor.fetchone()
    std = std[0]
    std = float(std)
    var = std*std
    Var.append([var])

    return Var

def S_X_Corr(cursor,Table,HouseNumber):
    Cross_Corr = []
    Day_of_the_week = "date_format(Date, '%W')"

    Monday = []
    Tuesday = []
    Wednesday = []
    Thursday = []
    Friday = []
    Saturday = []
    Sunday = []

    query_Monday = "SELECT Data FROM %s \
    WHERE %s = 'Monday' " % (Table, Day_of_the_week)

    query_Tuesday = "SELECT Data FROM %s \
    WHERE %s = 'Tuesday' " % (Table, Day_of_the_week)

    query_Wednesday = "SELECT Data FROM %s \
    WHERE %s ='Wednesday'" % (Table, Day_of_the_week)

    query_Thursday = "SELECT Data FROM %s \
    WHERE %s = 'Thursday'" % (Table, Day_of_the_week)

    query_Friday = "SELECT Data FROM %s \
    WHERE %s = 'Friday' " % (Table, Day_of_the_week)

    query_Saturday = "SELECT Data FROM %s \
    WHERE %s = 'Saturday' " % (Table, Day_of_the_week)

    query_Sunday = "SELECT Data FROM %s \
    WHERE %s = 'Sunday' " % (Table, Day_of_the_week)

    cursor.execute(query_Monday)
# Monday
    mons = cursor.fetchall()
    for m in mons:
        Monday.append(int(m[0]))

# Tuesday

    cursor.execute(query_Tuesday)

    tues = cursor.fetchall()
    for t in tues:
        Tuesday.append(int(t[0]))

# Wednesday
    cursor.execute(query_Wednesday)

    weds = cursor.fetchall()
    for w in weds:
        Wednesday.append(int(w[0]))
# Thursday
    cursor.execute(query_Thursday)

    thurs = cursor.fetchall()
    for t in thurs:
        Thursday.append(int(t[0]))
# Friday
    cursor.execute(query_Friday)

    fris = cursor.fetchall()
    for f in fris:
        Friday.append(int(f[0]))
# Saturday
    cursor.execute(query_Saturday)

    sats = cursor.fetchall()
    for s in sats:
        Saturday.append(int(s[0]))

# Sunday
    cursor.execute(query_Sunday)

    suns = cursor.fetchall()
    for s in suns:
        Sunday.append(int(s[0]))


    # Cross correlate on lists of the same lenght

    NumberMonday    = len(Monday)
    NumberTuesday   = len(Tuesday)
    NumberWednesday = len(Wednesday)
    NumberThursday  = len(Thursday)
    NumberFriday    = len(Friday)
    NumberSaturday  = len(Saturday)
    NumberSunday    = len(Sunday)

    NumberDays = [NumberMonday, NumberTuesday,NumberWednesday,NumberThursday,NumberFriday,NumberSaturday,NumberSunday]

    SmallestNumberOfReadings = min(NumberDays)

    snr = SmallestNumberOfReadings

    Monday = Monday[:snr]
    Tuesday = Tuesday[:snr]
    Wednesday = Wednesday[:snr]
    Thursday = Thursday[:snr]
    Friday = Friday[:snr]
    Saturday = Saturday[:snr]
    Sunday = Sunday[:snr]




    MonTue      = np.correlate(Monday,Tuesday)
    TueWed      = np.correlate(Tuesday,Wednesday)
    WedThurs    = np.correlate(Wednesday,Thursday)
    ThursFri    = np.correlate(Thursday,Friday)
    FriSat      = np.correlate(Friday,Saturday)
    SatSun      = np.correlate(Saturday,Sunday)
    SunMon      = np.correlate(Sunday,Monday)
    #print 'MonTue: '
    #print MonTue
    #print len(Monday)
    #print len(Tuesday)

    Cross_Corr.append(MonTue)
    Cross_Corr.append(TueWed)
    Cross_Corr.append(WedThurs)
    Cross_Corr.append(ThursFri)
    Cross_Corr.append(FriSat)
    Cross_Corr.append(SatSun)
    Cross_Corr.append(SunMon)

    return Cross_Corr



def SDifference(cursor,Table,HouseNumber):
    TotalDifference = []
    sums = 0
    HouseNumber = HouseNumber[0].split('_')[0]
    TotalDifference.append(HouseNumber)

    query = "SELECT Data FROM %s"  % (Table)
    cursor.execute(query)

    data = cursor.fetchall()
    first = int(data[0][0])

    for datum in data:
        second = int(datum[0])

        difference = abs(second - first)
        first = second
        sums = sums + difference

    TotalDifference.append(sums)
    return TotalDifference

def SPeaks(cursor,Table,HouseNumber):
    #P with (P(t) - P(t+-1 > 0.2 kW)      -- s_num_peaks

    Time = []



    # Find the households measured with interval ID1 ( 2 minutes over 1 month)
    Id1s = GetInfoId1(cursor)
    # Put them in a list for later, to convert to Watts from dWh we need to know the interval ID
    HouseholdId1s = []
    for i in range(0,len(Id1s)):
        HouseholdId1s.append(Id1s[i][0].split('_')[1])

    HouseNumber = HouseNumber[0].split('_')[0]
    Time.append(HouseNumber)

    # if Id = 1 -- *3.0 to get W
    # if Id = 3 -- *0.6 to get W

    if HouseNumber in HouseholdId1s:
        query = "SELECT (Data*3) FROM %s" % (Table)
    else:
        query = "SELECT (Data * 0.6) FROM %s " % (Table)

    cursor.execute(query)

    Datas = cursor.fetchall()

    first = 200
    peaks = 0

    TotalPeaks = []

    for datum in Datas:
        second = int(datum[0])

        difference = abs(second - first)
        first = second

        # if the difference is more than 200 watts
        if difference >= 200:
            peaks = peaks + 1

    TotalPeaks.append(peaks)

    return TotalPeaks




