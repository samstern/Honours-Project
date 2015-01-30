% Database Server
host = 'localhost';
 
% Database Username and Password
user = 'sam';
password = '';
 
% Database Name
dbName = 'Four_Weeks';
 
% JDBC Parameters
jdbcString = sprintf('jdbc:mysql://%s/%s', host, dbName);
jdbcDriver = 'com.mysql.jdbc.Driver';
 
% Set this to the path to your MySQL Connector/J JAR
javaaddpath('mysql-connector-java-5.1.6-bin.jar')
 
% Create the database connection object
dbConn = database(dbName, user, password, jdbcDriver, jdbcString);
isconnected = isconnection(dbConn);
 
% Query from database
%sqlquery1 ='CREATE VIEW rooms AS SELECT rm.roomID, rm.homeid, SUM(rd.value) FROM room rm, sensor s, reading rd WHERE rm.roomid=s.roomid AND s.sensorid=rd.sensorid GROUP BY rm.roomid';
%sqlquery2 ='SELECT h.homeid, SUM(values) FROM rooms r, home h WHERE r.homeid = h.homeid GROUP BY h.homeid';
%sqlquery = 'SELECT DISTINCT(h.homeid) FROM home h where h.category=''HES''';
%results = fetch(dbConn, sqlquery);
 
% Colse the database
%close(dbConn);
