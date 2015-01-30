import MySQLdb as mdb
from functions_subset import GetInfoId1

"""
TODO (when running on full dataset)

- Change con to ...Total_Profile_Monthly
- Change to Ten_Mins for create_table and populate_table

Households with ID1 are only measured for a month so we aren't actually splitting the households.
This script actually only coppies the ID1 tables from the Ten_Mins_Subset database and puts it into the 
Total_Profile_Monthly_Subset database under a new name.

Don't need to do this for ID2 as they appear to be redundant. Their readings overlap with those of ID3.
"""
con = mdb.connect('localhost', 'root', '', 'Total_Profile_Monthly_Subset');
with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)
    tables = GetInfoId1(cur)
    for table in tables:
        HouseNumber = str(table)
        TableNumber = str(table)

        HouseNumber = HouseNumber.split('_')[5]


        TableNumber = TableNumber.split()
        TableNumber = TableNumber[2].split("'")[1]

        create_table = "CREATE TABLE %s_m like Ten_Mins_Subset.%s" %(HouseNumber,TableNumber)
        cur.execute(create_table)

        populate_table = "INSERT INTO %s_m SELECT * FROM Ten_Mins_Subset.%s" %(HouseNumber,TableNumber)

        cur.execute(populate_table)
