import MySQLdb as mdb



con = mdb.connect('localhost', 'root', '', 'seasonal_adjusted');

with con:

    # Use a Dictionary Cursor
    cur = con.cursor(mdb.cursors.DictCursor)

    #get un-summed tables
    cur.execute("show tables from house_sets where tables_in_house_sets like 't%'")

    tables = cur.fetchall()

    
    #Tables can't be called numbers, use c+number as temporary holding name    
    for table in tables:

        TableNumber = table["Tables_in_house_sets"]
        create_t_table = "CREATE TABLE %s LIKE House_Sets.%s" %(TableNumber, TableNumber)
        cur.execute(create_t_table)

        query_for_t_table = "SELECT t.IntervalID, t.HouseID, t.Appliance, t.Data*a.Factor as Data, t.Dates, t.Hour, t.Minute \
        FROM house_sets.%s t JOIN \
        (SELECT app.Appcode, adj.* \
        FROM hes_database.appliance_types app JOIN hes_database.seasonal_adjustments adj ON app.Apptype=adj.Apptype) a ON \
        dayofyear(t.dates)=a.day AND t.Appliance=a.Appcode" %(TableNumber)

        populate_t_table = "INSERT INTO %s \
        (IntervalID, HouseID, Appliance, Data, Dates, Hour, Minute) %s" %(TableNumber,query_for_t_table)

        cur.execute(populate_t_table)


