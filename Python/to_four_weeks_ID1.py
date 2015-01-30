import MySQLdb as mdb
from functions import GetInfoId1
from collections import Counter

"""
Finds the mode day that the readings start for each household. 
For each household, the data is chopped off the top up to the the start date (i.e the mode) and stored in a temp table
If there are still 28 days (4 weeks) once the first few days have been chopped off, then great. 
Otherwise, try to stick the chopped off data at the end if the days of the week lign up or re-use days to make it 28 days long

TODO (when running on full dataset)
- change all _subset things
"""


def getStartDay(cur, tables):
    #find the mode starting day
    startDays = [0 for x in tables]
    i=0
    for table in tables:

        Table_Name = str(table)

        Table_Name = Table_Name.split()
        Table_Name = Table_Name[2].split("'")[1]

        getStartDay = "select dayofweek(Date) from Ten_Mins.%s order by date desc limit 1" %(Table_Name)
        cur.execute(getStartDay)
        startDays[i] = str(cur.fetchall()).split(': ')[1][0]
        i+=1


    return int(Counter(startDays).most_common(1)[0][0])

con = mdb.connect('localhost', 'root', '', 'Four_Weeks');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    tables = GetInfoId1(cur)
    startDay = getStartDay(cur, tables)
    print "Start Day is:%s" %startDay

    for table in tables:

        Table_Name = str(table)

        Table_Name = Table_Name.split()
        Table_Name = Table_Name[2].split("'")[1]

        selectStartDay = "SELECT MIN(Date) FROM Ten_Mins.%s WHERE DAYOFWEEK(Date)=%s"%(Table_Name,startDay)

        #create temp table to store the data chopped off the top
        tableOfTops = "CREATE TEMPORARY TABLE tops_%s \
        (Id mediumint, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int)"%(Table_Name)
        cur.execute(tableOfTops)

        #find all data where the date is less than the first occurence of startDay
        insert_into_tops_table = "INSERT INTO tops_%s \
        (Id, HouseId, Data, Date, Hour, Minute)\
        SELECT * FROM Ten_Mins.%s WHERE Date <(%s)" %(Table_Name,Table_Name,selectStartDay)
        
        cur.execute(insert_into_tops_table)

        #create a table where the minimum date is the start date and the values go up to at most t+28
        createFourWeekTable = "CREATE TABLE %s \
        (Id mediumint, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int)"%(Table_Name)
        cur.execute(createFourWeekTable)

        insert_into_table = "INSERT INTO %s \
        (Id, HouseId, Data, Date, Hour, Minute)\
        SELECT * FROM Ten_Mins.%s WHERE Date < Date(Date_Add((%s),Interval 28 day))\
        AND Date>=(%s)"%(Table_Name,Table_Name,selectStartDay,selectStartDay)

        cur.execute(insert_into_table)

        countDates = "SELECT COUNT(DISTINCT(Date)) from %s" %(Table_Name)
        cur.execute(countDates)
        numDays = int(cur.fetchall()[0].values()[0])
        #get day-of-week from greatest date
        cur.execute("SELECT DAYOFWEEK(max(Date)) FROM %s limit 1"%(Table_Name))
        maxDay = int(cur.fetchall()[0].values()[0])

        while numDays<28:
                #get data from the next day of the week from the temp table
                maxDay = maxDay+1

                if maxDay>7:
                    maxDay=maxDay-7
                getNextDay = "SELECT Date FROM tops_%s WHERE DAYOFWEEK(Date) = %s limit 1" %(Table_Name,maxDay%7)
                cur.execute(getNextDay)
                nextDay = cur.fetchall()

                #don't want to re-use the same day more than once
                #create_used = "CREATE TEMPORARY TABLE used_%s (Date Date)" %(Table_Name)
                #cur.execute(create_used)
                if nextDay == ():
                    #need to copy used data
                    #get first day from Table_Name with the appropriade day-of-week
                    getDay = "SELECT Date from %s where DAYOFWEEK(Date) = %s LIMIT 1"%(Table_Name,maxDay)
                    insertData = "INSERT INTO %s (SELECT DISTINCT * FROM %s WHERE Date=(%s) order by Hour, Minute)"%(Table_Name, Table_Name,getDay)
                    cur.execute(insertData)
                else:
                    insertData = "INSERT INTO %s (SELECT * FROM tops_%s WHERE DAYOFWEEK(Date) = %s \
                    order by Hour, Minute)"%(Table_Name, Table_Name, maxDay)
                    cur.execute(insertData)
                numDays = numDays+1              
                















