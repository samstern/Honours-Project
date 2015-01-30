#!/usr/bin/python

import MySQLdb as mdb
import random as rand

warning = "running this script will overwrite the households held in apg_test and replace the table with new households.\n \
Any work done that is dependent on the this table could be affected. \n \
Are you sure you want to proceed? (type yes or no)"

print warning
yes = set(['yes','y'])
no = set(['no','n'])
choice = raw_input().lower()

if choice in yes:
	print "ok, proceeding."

	con = mdb.connect('localhost', 'root', '', 'hes_database_subset');
	with con:

		# Use a Dictionary Cursor
	    cur = con.cursor(mdb.cursors.DictCursor)
	    # Get the household ID numbers
	    cur.execute("Select Distinct Household from hes_database.total_profiles")
	    # Retrieve them all
	    HousesDict = cur.fetchall()
	    HouseList = ["" for x in range(0,len(HousesDict))]
	    i=0
	    for h in HousesDict:
	    	HouseList[i]=h["Household"]
	    	i+=1

	    tenHouseholds = rand.sample(HouseList, 10)

	    dropIfExists = "DROP TABLE IF EXISTS apg_test"
	    cur.execute(dropIfExists)

	    createTestGroup = "CREATE TABLE apg_test \
	    (IntervalID mediumint(8), Household varchar(8), Appliance smallint unsigned, Date date, Data int, TimeInterval time)"
	    cur.execute(createTestGroup)

	    fillTestGroup = "INSERT INTO apg_test \
	    (IntervalID, Household, Appliance, Date, Data, TimeInterval) \
	    SELECT * from hes_database.appliance_group_data WHERE Household IN (%s)"
	    in_p=', '.join(list(map(lambda x: '%s', tenHouseholds)))
	    fillTestGroup = fillTestGroup % in_p
	    cur.execute(fillTestGroup,tenHouseholds)

	    print tenHouseholds

else:
	print "job canceled."

