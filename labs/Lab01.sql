/*

Group 4
Name 1: Diego Barreras
Name 2: Brian Gonzalez

Lab 1 - MySQL Basics

 */



/*Q1:  List the Title, UPC, and Genre of all CD titles. */


	SELECT  Title, UPC, Genre
    FROM Titles;


/*Q2: List the information of CD(s)  produced by the artist whose ArtistID is 2.*/


	SELECT TitleID, ArtistID, Title, StudioID, UPC, Genre
	FROM Titles
	WHERE ArtistID = 2 ;     


/* Q3: List the First Name, Last Name, HomePhome, and Email address of all members. */

	SELECT FirstName, LastName, HomePhone, EMail
	FROM Members;


/*Q4: List the Member ID of all male members.*/

	SELECT MemberID, Gender
	FROM Members
	WHERE GENDER = 'M';

/* Q5: List the Member ID and Country of all members in Canada.*/

	SELECT MemberID, Country
	FROM Members
	WHERE Country = 'Canada';

/*Q6: List the titleID, title, and lengthseconds of every track that runs more than 300 seconds and does not have mp3 files. */

	SELECT TitleID, LengthSeconds, TrackTitle
	FROM Tracks
	Where LengthSeconds > 300 AND MP3 = 0;


/* Q7: List the names and work phone numbers of all members who have work phones.*/

	SELECT FirstName, LastName, WorkPhone
	FROM Members
	WHERE WorkPhone IS NOT NULL;

/* Q8: List the leadsource of all artists.*/

	SELECT DISTINCT LeadSource
	FROM Artists;

/*Q9: List the studio name, post code and phone of all studios. 
Label the column studioName as "Studio_Name" and postcode as "Post_code".*/

	SELECT StudioName AS 'Studio_Name', PostalCode AS 'Post_Code' , Phone
	FROM Studios;
    
/*Q10: List the artist name and entry date for all artists with entry dates in 2002.*/
    
    SELECT ArtistName, EntryDate
    FROM Artists
    WHERE EntryDate BETWEEN '2002-01-01' AND '2002-12-31';
    
    
    
    
 /* Q11: If the Base field reports the daily base salary of each salesperson, 
 report the Firstname, Lastname, and weekly (5 workdays) salary of each salesperson whose weekly
 salary is greater than $1000.*/
 

	SELECT FirstName AS 'First Name', LastName AS 'Last Name', Base AS 'Weekly Salary'
	 FROM SalesPeople
	Where Base > 200;

/* Q12: List all fields from the Tracks for any track whose trackNum is the same as its TitleID.*/

	SELECT *
	FROM Tracks
	Where TrackNum = TitleID;
