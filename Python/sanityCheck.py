import MySQLdb as mdb
from functions import GetInfoId1
from functions import GetInfoId3

con = mdb.connect('localhost', 'sam', '', 'Four_Weeks');
with con:
    cur = con.cursor(mdb.cursors.DictCursor)
    cur.execute("show tables from Four_Weeks")
    tables = cur.fetchall()
    tables1 =GetInfoId1(cur)
    tables3 =GetInfoId3(cur)
    count=0
    for table in tables:
        Table_Name = table["Tables_in_four_weeks"]

        #Table_Name = Table_Name.split()
        #Table_Name = Table_Name[2].split("'")[1]

        countRows="select count(*) from %s" %(Table_Name)
        cur.execute(countRows)
        numRows = cur.fetchall()[0].values()[0]
        if numRows != 4032:
            print "%s : %s" %(Table_Name, numRows)
        count+=1
    print count

