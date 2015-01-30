function [data] = importMonthlyData(dbConn)


selectHouseholds ='show tables';

%get names of each instance
householdNames = char(fetch(dbConn,selectHouseholds));


for i =1:length(householdNames)
    data{i}=importTableData(householdNames(i,:));
end

function [data] = importTableData(table)

%{
connects to the database and returns the the data from the input table

the function argument must be a table that exists in Total_Profile_Monthly_Subset
%}

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'cellarray');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using JDBC driver.
conn = database('', 'root', '', 'Vendor', 'MYSQL', 'Server', 'localhost', 'PortNumber', 3306);

%Read data from database.
curs = exec(conn, sprintf('SELECT * FROM Total_Profile_Monthly_Subset.%s ',table));

curs = fetch(curs);
close(curs);

%Assign data to output variable
data = curs.Data;

%Close database connection.
close(conn);

%Clear variables
clear curs conn
%identifier = genvarname(householdNames);


