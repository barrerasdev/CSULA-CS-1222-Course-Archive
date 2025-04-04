-- Diego Barreras
-- Brian Gonzalez
-- Lab 07

-- Q1: Add a new artist with the following information. Use a proper function to automatically get today's date.

INSERT INTO Artists (ArtistID, ArtistName, City, Region, Country, WebAddress, EntryDate, LeadSource)
VALUES (12, 'November', 'New Orleans', 'LA', 'USA', 'www.november.com', CURDATE(), 'Directmail');

-- Q2: The title 'Time Flies' now has a new track, the 11th track 'Spring', which is 150 seconds long 
-- and has only an MP3 file. Insert the new track into the Tracks table.

INSERT INTO Tracks (TitleID, TrackNum, TrackTitle, LengthSeconds, MP3, RealAud)
VALUES (
  (SELECT TitleID 
  FROM Titles 
  WHERE Title = 'Time Flies'), 11, 'Spring', 150, 1, 0);
    
-- Q3: Create a new table called Members2 with the fields as the Members table.

CREATE TABLE Members2 LIKE Members;

-- Q4: Populate Members2 the content of the Members table.

INSERT INTO Members2 
SELECT * 
FROM Members;

-- Q5: The area code for Columbus, Ohio has been changed from 277 to 899. Update the homephone
--  and workphone numbers of all members in the Members2 table accordingly.

UPDATE Members2
SET HomePhone = REPLACE(HomePhone, '(277)', '(899)'),
    WorkPhone = REPLACE(WorkPhone, '(277)', '(899)')
WHERE City = 'Columbus' AND Region = 'OH';

-- Q6: Salesperson Bob Bentley has agreed to turn over all his female members to salesperson Lisa 
-- Williams whose sales id is 2. Update the Members2 table accordingly. 

UPDATE Members2
SET SalesID = 2
WHERE SalesID = 1 AND Gender = 'F';

-- Q7: Members Doug Finney and Terry Irving are forming artist called "Doug and Terry." Add this record to the Artists table

INSERT INTO Artists (ArtistID, ArtistName, EntryDate, City, Region, Country)
SELECT  13, 'Doug and Terry', CURDATE(), City, Region, Country
FROM Members
WHERE MemberID = 32;

-- Q8: Add the appropriate new records to the XrefArtistsMembers table for the artist "Doug and Terry" (see Q7). 
-- Doug is the responsible party. Don’t hand-code any data for the insert that can be looked up from the Members2 table.

INSERT INTO XrefArtistsMembers (MemberID, ArtistID, RespParty)
SELECT 13, (SELECT ArtistID FROM Artists WHERE ArtistName = 'Doug and Terry' LIMIT 1), 1;  
    
-- Q9: Lyric Music has decided to set up a web page for every artist who doesn't have 
-- a web site. The web address will be "www.lyricmusic.com/" followed by the ArtistID.
--  Fill this in for every artist record that doesn't already have a web site.

UPDATE Artists
SET WebAddress = CONCAT('www.lyricmusic.com/', ArtistID)
WHERE WebAddress IS NULL OR WebAddress = '';

-- Q10: Delete all members who work for the artist 'Sonata' from the Members2 table.

DELETE FROM Members2
WHERE MemberID IN (SELECT X.MemberID
					FROM XrefArtistsMembers X
					JOIN Artists A 
                    ON X.ArtistID = A.ArtistID
					WHERE A.ArtistName = 'Sonata');
                    
-- Q11: Modify the scheme of the Members2 table as follows: create a new column `Name`; delete the columns `FirstName` and `LastName`.

ALTER TABLE Members2
ADD COLUMN Name VARCHAR(50),
DROP COLUMN FirstName,
DROP COLUMN LastName;

-- Q12: Delete the table Members2 from the database.

DROP TABLE Members2;

