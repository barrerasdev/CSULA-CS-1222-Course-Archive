DROP TABLES IF EXISTS Artists,Genre, Members, Titles, Tracks,SalesPeople,Studios,XrefArtistsMembers;
DROP TABLES IF EXISTS Authors,Publishers,Titles,Title_Authors,Royalties;
DROP TABLES IF EXISTS Products,Customers,Orders,Order_details;
DROP TABLES IF EXISTS Sailors,Reserves,Boats;
DROP TABLES IF EXISTS Students,Professors,Supervise;


CREATE TABLE Students (
	student_id int, 
	student_name varchar (50) NOT NULL ,
	gender  char(1)  NULL,
	age float NULL ,
	EMail varchar(40) NULL ,
	EntryDate date NULL
);


CREATE TABLE Professors (
	prof_id int, 
	prof_name varchar (50) NOT NULL ,
	dept    varchar(5) NULL,
	officephone varchar(16) NULL ,
	EMail varchar(40) NULL ,
	webAddress varchar(40) NULL 
);

CREATE TABLE Supervise (
	prof_id int, 
	student_id  int,
	project  varchar(10) NULL,
	startdate date NULL
	
);


Insert Into Students Values(0001, "Tom", 'M', 19, "tom@yahoo.com", "2001-01-01");
Insert Into Students Values(0002, "John", 'M', 20, "John@hotmail.com", "2001-06-01");
Insert Into Students Values(0003, "Anmy", 'F', 15, "Anmy@gmail.com", "2003-01-01");
Insert Into Students Values(0004, "Dustin", 'M', 24, "Dustin@hotmail.com", "2002-03-01");
Insert Into Students Values(0005, "Mary", 'F', 22, "Mary@sbc.net", "2004-01-030");
Insert Into Students Values(0006, "Jessica", 'F', 21, "Jessica@calstatela.edu", "2004-01-01");
Insert Into Students Values(0007, "Rainy", 'M', 19, "rainy@calstatela.edu", "2004-01-12");
Insert Into Students Values(0008, "Kelvin", 'M', 19, "Kelvin@calstatela.edu", "2004-01-12");


Insert Into Professors Values(2001, "Scott", 'CS', "201-234-3213", "scott@calstatela.edu", "www.calstatela.edu/faculty/scott/");
Insert Into Professors Values(2002, "David", 'CE', "201-234-3112", "david@calstatela.edu", "www.calstatela.edu/faculty/david/");
Insert Into Professors Values(2003, "Judy", 'CE', "201-234-3002", "Judy@calstatela.edu", "www.calstatela.edu/faculty/Judy/");
Insert Into Professors Values(2004, "Gerald", 'CS', "201-234-3102", "Gerald@calstatela.edu", "www.calstatela.edu/faculty/Gerald/");
Insert Into Professors Values(2005, "Charlie", 'CIS', "201-234-3291", "Charlie@calstatela.edu", "www.calstatela.edu/faculty/Charlie/");
Insert Into Professors Values(2006, "Jennifer", 'CIS', "201-234-3621", "Jennifer@calstatela.edu", "www.calstatela.edu/faculty/Jennifer/");
Insert Into Professors Values(2007, "Jason", 'CIS', "201-234-3921", "Jason@calstatela.edu", "www.calstatela.edu/faculty/Jason/");

Insert Into Supervise Values(2001, 0001, "project01","2002-02-01");
Insert Into Supervise Values(2001, 0002, "project01","2002-03-01");
Insert Into Supervise Values(2001, 0003, "project02","2002-03-01");
Insert Into Supervise Values(2002, 0005, "project03","2002-09-01");
Insert Into Supervise Values(2002, 0006, "project04","2005-11-01");
Insert Into Supervise Values(2003, 0004, "project05","2003-10-01");
Insert Into Supervise Values(2003, 0004, "project06","2004-10-01");
 
show tables;