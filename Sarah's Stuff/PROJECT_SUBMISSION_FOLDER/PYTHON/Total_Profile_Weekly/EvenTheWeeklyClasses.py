#!/usr/bin/python

import MySQLdb as mdb
import random

con = mdb.connect('localhost', 'root', '', 'Total_Profile_Weekly');
with con:

    cur = con.cursor()

    twos_tot_tables = []


    Occupancy_twos = "Select hes.HouseID \
        FROM hes_database.home_information hes \
        WHERE hes.Occupancy = 6"
    cur.execute(Occupancy_twos)
    all_tables = cur.fetchall()


    for row in all_tables:
        row = str(row[0])+'%'
        query = "show tables like '%s'" % (row)
        cur.execute(query)

        total_prof_tables =  cur.fetchall()

        for thing in total_prof_tables:
            twos_tot_tables.append(thing[0])

    print len(twos_tot_tables)

    """while len(twos_tot_tables)>340:
        TheChoice = random.choice(list(twos_tot_tables))
        twos_tot_tables.remove(TheChoice)
        dropTableQuery = "drop table %s" % (TheChoice)
        cur.execute(dropTableQuery)

    print len(twos_tot_tables)"""

