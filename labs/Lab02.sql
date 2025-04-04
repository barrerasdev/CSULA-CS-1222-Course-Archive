-- Group 4
-- Diego Barreras
-- Brian Gonzalez
-- Lab 02 - Aggregate


-- Q1: List the first name, last name, home phone, and gender of all members
-- from Georgia who either have a home phone in area code 822 or are  female

	SELECT FirstName, LastName, HomePhone, Gender
	FROM Members
	WHERE Region = 'GA'  AND HomePhone LIKE '822_______' AND Gender = 'F';

-- Q2: List the TitleID, Title, and UPC of any titles whose UPC end with '2'

	SELECT TitleID, Title, UPC
	FROM Titles
	WHERE UPC LIKE '_________2' ;

-- Q3:  List the TitleID, TrackNum, and TrackTitle of all tracks with 'Song' at the beginning of the TrackTitle

	SELECT TitleID, TrackNum, TrackTitle
	FROM Tracks
	WHERE TrackTitle LIKE 'Song %';

-- Q4: Report the average, shortest, and longest track length in minutes of all tracks.*/

	SELECT AVG(LengthSeconds)/60, MIN(LengthSeconds)/60, MAX(LengthSeconds)/60
	FROM Tracks;

-- Q5: Report the total time in minutes of all tracks with length greater than 150 seconds.

	SELECT SUM(LengthSeconds)/60 AS 'Minutes' 
	FROM Tracks
	WHERE LengthSeconds > '150';

-- Q6:  List the number of track titles that begin with the letter 's' and the average length of these tracks in seconds

	SELECT COUNT(TitleID) AS '# of Track Titles', AVG(LengthSeconds) AS AverageLength
	From Tracks
	WHERE TrackTitle LIKE 's%';

-- Q7: List the number of tracks, total length in seconds, and the average length in seconds of all tracks with titleID 4.

	SELECT COUNT(*) AS 'Number Of Tracks' , SUM(LengthSeconds)AS 'Total Length (s)', AVG(LengthSeconds) AS 'Average Length (s)'
	FROM Tracks
	WHERE TitleID = '4';

-- Q8 Report the number of male members who are in the US.

	SELECT COUNT(*)
	FROM Members
	WHERE Gender = 'M' and Country = 'USA';

-- Q9: Report the number of tracks for each TitleID

	SELECT TitleID, COUNT(TrackNum) As '# of Tracks'
	FROM Tracks
	GROUP BY TitleID;
    
-- Q10: Report the total time in minutes for each TitleID*/

	SELECT TitleID, SUM(LengthSeconds)/60
	FROM Tracks
	GROUP BY TitleID;

-- Q11: Report region and the number of members in each region in the Members table. Sort the results by the region.

	SELECT Region, COUNT(MemberID) AS 'Members'
	FROM Members
	GROUP BY Region;

-- Q12:  Report the number of members by region and gender. Sort the results by region

	SELECT Region,COUNT(MemberID) AS '# of Members',  Gender
	FROM Members
	GROUP BY Region, Gender
	ORDER BY Region;

-- Q13: Report the TitleID, average, shortest, and longest track length in minutes of all tracks for each TitleID.
--  Use proper column alias.

	SELECT TitleID, AVG(LengthSeconds)/60 AS Average, MIN(LengthSeconds)/60 as Shortest, MAX(LengthSeconds)/60 as Longest
	FROM Tracks
	GROUP BY TitleID;

-- Q14 For each kind of LeadSource, report the number of artists who came into the system through that lead source, 
-- the earliest EntryDate, and the most recent EntryDate. 

	SELECT LeadSource, count(ArtistID), Min(EntryDate) AS 'Earliest Date', Max(EntryDate) AS 'Most Recent'
	From Artists
	GROUP BY LeadSource;

-- Q15: Report the TitleID, average, shortest, and longest track length in minutes of all tracks for
-- each TitleID with an average length greater than 300. Use proper column alias.

	SELECT TitleID, AVG(LengthSeconds)/60 AS Average, MIN(LengthSeconds)/60 AS Shortest, MAX(LengthSeconds)/60 AS Longest
	FROM Tracks
	GROUP BY TitleID
	HAVING AVG(LengthSeconds) > 300;

--  Q16 : Report the TitleID, average, shortest, and longest track length in minutes of all MP3 tracks (i.e. MP3 = 1) for each TitleID 
--  with an average length greater than 300.Use proper column alias.

	SELECT TitleID, AVG(LengthSeconds)/60 AS Average, MIN(LengthSeconds)/60 AS Shortest, MAX(LengthSeconds)/60 AS Longest
	FROM Tracks
	WHERE MP3 = '1'
	GROUP BY TitleID
	HAVING AVG(LengthSeconds) > 300;

-- Q17: Report the TitleID and number of tracks for any TitleID with fewer than nine tracks.

	SELECT TitleID, COUNT(*) AS '# of Tracks'
	FROM Tracks
	GROUP BY TitleID
	HAVING COUNT(TrackNum) < '9';

-- Q18:  For any region that has more than one member with an e-mail address, list the region and the number of members with an e-mail address.

	SELECT Region, Count(EMail) AS 'Members with Email'
	FROM Members
	GROUP BY Region
	HAVING COUNT(EMail) > 1;
