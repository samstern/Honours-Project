#!/usr/bin/python

import MySQLdb as mdb
import timeit


con = mdb.connect('localhost', 'root', '', 'House_Sets');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    # Get the household ID numbers
    cur.execute("Select Distinct Household from hes_database.appliance_group_data")
    # Retrieve them all
    HouseNumbers = cur.fetchall()

    for row in HouseNumbers:
        HN = row["Household"]

        get_appliance_lists = "Select distinct Appliance from hes_database.total_profiles where Household = %s" %(HN)
        cur.execute(get_appliance_lists)
        Total_Profile_Appliance_List = cur.fetchall()
        All_List = []
        for line in Total_Profile_Appliance_List:

            TPAL = line["Appliance"]
            All_List.append(TPAL)
        Appl_List = list(set(All_List))

        print HN, tuple(Appl_List)