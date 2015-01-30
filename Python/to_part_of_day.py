import MySQLdb as mdb
"""
Split into 4 parts of day
6am-9am -- when kids get up and go to school
9am-3pm -- when kids are at school
3pm-10pm -- before kids go to bed
10pm-6am -- asleep
"""

con = mdb.connect('localhost', 'root', '', 'Part_Of_Day');

with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)

    cur.execute("show tables from Four_Weeks")

    tables = cur.fetchall()

    
    #Tables can't be called numbers, use c+number as temporary holding name    
    for table in tables:

        TableNumber = table["Tables_in_four_weeks"]
        drop_if_exists = "drop table if exists %s" %(TableNumber)
        cur.execute(drop_if_exists)
        create_table = "create table %s like Four_Weeks.%s" %(TableNumber,TableNumber)
        cur.execute(create_table)