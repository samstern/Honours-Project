import MySQLdb as mdb
import timeit

"""
To make things more consistent, have every household start from midnight. 
It will make the rest of the pre-prossessing easier and hopefully get rid of some anolalous
data from setting up the appliances.

TODO for real (not test set)
- first query, change to tables_in_house_sets 
- change TableNUmber =table[...]

"""


con = mdb.connect('localhost', 'root', '', 'House_Sets_Subset');

with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)


    cur.execute("show tables where tables_in_house_sets_subset like 'dt_%'")

    tables = cur.fetchall()


    for table in tables:
    	TableNumber = table["Tables_in_house_sets_subset"]

    	#create a temporary table that stores the first date we want to keep. Need a temp table because 
    	#you can't update a table and select from it simultaniously.
    	firstMidnight= "create temporary table firstMidnight_%s \
    	(Dates Date)\
    	(select Date from %s where Hour=0 and Minute=0 order by Date asc limit 1)" %(TableNumber,TableNumber)
    	cur.execute(firstMidnight)

    	#now get the first (and only) element in the temp table
    	cutoff_query = "select * from firstMidnight_%s" %(TableNumber)
    	cur.execute(cutoff_query)

    	# fetchall() returns a tuble of dictionaries of tuples. We only want one element
    	cutoff = (cur.fetchall())[0].values()[0]

    	#now actually do the deleting
    	deleteRows="delete from %s \
    	where Date < '%s'" %(TableNumber,cutoff)

    	cur.execute(deleteRows)


