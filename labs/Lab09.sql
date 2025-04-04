-- Diego Barreras
-- Brian Gonzalez

-- Lab 09: Views

-- Q1: Create a view that reports the number of artists who entered in the same year and the total number.         

CREATE VIEW SameYear AS
SELECT EntryDate, COUNT(*), (SELECT COUNT(*) FROM Artists)
FROM Artists
GROUP BY EntryYear;    
    
-- Q2: Create a view that reports the artist id and the artist name of all artists who have members not in USA.

	CREATE VIEW NonUSAMembers AS
		SELECT a.ArtistID, a.ArtistName
		FROM Artists a
		WHERE a.ArtistID NOT IN (SELECT DISTINCT xm.ArtistID 
								FROM XrefArtistsMembers xm
								JOIN Members m ON xm.MemberID = m.MemberID
								WHERE m.Country = 'USA');
	SELECT *
    FROM NonUSAMembers;
    show full tables;

-- Q3: Modify the view created in question Q2 to report the artist name and web address of all artists who have 
-- members not in USA. 

CREATE OR REPLACE VIEW NonUSAMembers AS
SELECT a.ArtistID, a.WebAddress
FROM Artists a
WHERE a.ArtistID NOT IN (SELECT DISTINCT xm.ArtistID
   		 FROM XrefArtistsMembers xm
   		 JOIN Members m ON xm.MemberID = m.MemberID
   		 WHERE m.Country = 'USA');

-- Q4: Create a view that lists the names of artists and a count of the number of members assigned to that artist.

	CREATE VIEW ArtistMemberCount AS
    SELECT a.ArtistName, COUNT(xm.MemberID) AS MemberCount
    FROM Artists a
	LEFT JOIN XrefArtistsMembers xm 
    ON a.ArtistID = xm.ArtistID
    GROUP BY a.ArtistName;
    
    SELECT *
    FROM ArtistMemberCount;
    show full tables;

-- Q5: Create a view that reports all the information of the longest title(s).

	CREATE VIEW LongestTitle AS
   	 SELECT *
   	 FROM Tracks
   	 WHERE LengthSeconds = (SELECT MAX(LengthSeconds)
   							FROM Tracks);
-- Q6: Create a view that reports the title ID, track number, track title, lengthseconds, the maximum lengthseconds 
-- for all tracks of the title id, and the difference value between the lengthseconds and the maximum value for each 
-- title id.

	CREATE VIEW IDNumTitleLengthLengthMaxDiffMin AS
		SELECT t.TitleID, tr.TrackNum, tr.TrackTitle, tr.LengthSeconds,
			(SELECT MAX(LengthSeconds) FROM Tracks t_max WHERE t_max.TitleID = t.TitleID) AS MaxLengthSeconds,
			tr.LengthSeconds - (SELECT MAX(LengthSeconds) FROM Tracks t_max WHERE t_max.TitleID = t.TitleID) AS LengthDifference
		FROM Tracks tr
		JOIN Titles t 
		ON tr.TitleID = t.TitleID;
	SELECT *
	FROM IDNumTitleLengthLengthMaxDiffMin;
	show full tables;
        
-- Q7: Create an updatable view that reports the information of all tracks that are longer than 300 seconds. Make sure
-- that no new track shorter than 300 seconds can be inserted into the Tracks table through the view.

	ALTER TABLE Tracks ADD COLUMN IsLongerThan300 BOOLEAN;
    
	UPDATE Tracks SET IsLongerThan300 = (LengthSeconds > 300);

	CREATE VIEW TracksLongerThan300 AS 
	SELECT *
	FROM Tracks
	WHERE IsLongerThan300 = TRUE; 
    
-- Test
	SELECT * 
	FROM TracksLongerThan300;
	SHOW FULL TABLES;

-- Q8: Redefine the view created in question Q7 to report the information of all tracks that are longer than 280 
-- seconds. Make sure that no new track shorter than 280 seconds can be inserted into the Tracks table through the view.

	ALTER TABLE Tracks ADD COLUMN IsLongerThan280 BOOLEAN;

	UPDATE Tracks SET IsLongerThan280 = (LengthSeconds > 280);	

	CREATE OR REPLACE VIEW TracksLongerThan280 AS
	SELECT *
	FROM Tracks
	WHERE IsLongerThan280 = TRUE;

-- Test 
	SELECT * 
	FROM TracksLongerThan280;
	SHOW FULL TABLES;


-- Q9: Rename the view created in question Q7 to another name

	RENAME TABLE TracksLongerThan280
	TO TwoEightyPlus;

-- Test	
	SELECT * 
	FROM TwoEightyPlus;

-- Q10: Delete the views created in questions Q3, Q4 and Q5.

SHOW FULL TABLES;

DROP VIEW IF EXISTS NonUSAMembers;
DROP VIEW IF EXISTS ArtistMemberCount;
DROP VIEW IF EXISTS LongestTitle;
