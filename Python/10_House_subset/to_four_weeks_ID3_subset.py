import MySQLdb as mdb
from functions import GetInfoId1
from functions import GetInfoId3
from to_four_weeks_ID1 import getStartDay
from collections import Counter

con = mdb.connect('localhost', 'root', '', 'Four_Weeks');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)

    #use the mean start date from the ID1 households
    tablesID1 = GetInfoId1(cur)
    startDay = getStartDay(cur, tablesID1)
    print "Start Day is:%s" %startDay

    tables3 =GetInfoId3(cur)

    for table in tables3:

        Table_Name = str(table)

        Table_Name = Table_Name.split()
        Table_Name = Table_Name[2].split("'")[1]

        #create temp table to store the data chopped off the top
        tableOfTops = "CREATE TEMPORARY TABLE tops_%s \
        (Id mediumint, HouseID varchar(8), \
        Data int, Date Date, Hour int, Minute int)"%(Table_Name)
        cur.execute(tableOfTops)


        selectStartDay = "SELECT MIN(Date) FROM Ten_Mins_Subset.%s WHERE DAYOFWEEK(Date)=%s"%(Table_Name,startDay)
        #find all data where the date is less than the first occurence of startDay
        insert_into_tops_table = "INSERT INTO tops_%s \
        (Id, HouseId, Data, Date, Hour, Minute)\
        SELECT * FROM Ten_Mins_Subset.%s WHERE Date <(%s)" %(Table_Name,Table_Name,selectStartDay)
        
        cur.execute(insert_into_tops_table)

        i=1
        getRemainingDays="SELECT COUNT(DISTINCT date) FROM Ten_Mins_Subset.%s WHERE DATE >(%s)" %(Table_Name,selectStartDay)
        cur.execute(getRemainingDays)
        remainingDays=int(cur.fetchall()[0].values()[0])

        while remainingDays>=28 and i < 15:
            create_Ith_table = "CREATE TABLE %s_%02d \
            (Id mediumint, HouseID varchar(8), \
            Data int, Date Date, Hour int, Minute int)" %(Table_Name,i)

            cur.execute(create_Ith_table)

            insert_into_Ith_table = "INSERT INTO %s_%02d \
            (Id, HouseId, Data, Date, Hour, Minute)\
            SELECT * FROM Ten_Mins_Subset.%s WHERE Date < Date(Date_Add((%s),Interval 28 day))\
            AND Date>=(%s)"%(Table_Name,i,Table_Name,selectStartDay,selectStartDay)

            cur.execute(insert_into_Ith_table)

            selectStartDay = "SELECT DATE_ADD(MAX(Date), INTERVAL 1 DAY) FROM %s_%02d" %(Table_Name,i)

            getRemainingDays="SELECT COUNT(distinct date) FROM Ten_Mins_Subset.%s WHERE DATE >(%s)" %(Table_Name,selectStartDay)
            cur.execute(getRemainingDays)
            remainingDays=int(cur.fetchall()[0].values()[0])
            i=i+1

