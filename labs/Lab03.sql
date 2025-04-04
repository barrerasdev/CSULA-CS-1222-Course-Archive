-- Diego Barreras
-- Brian Gonzalez
-- Lab 03

-- Q1: List length of the longest RealAud track in the 'metal' genre.

SELECT MAX(LengthSeconds)
FROM Tracks
WHERE RealAud = 1 AND TitleID = ( SELECT TitleID
   								 FROM Titles
   								 WHERE Genre = 'metal');


-- Q2: List the ArtistID, ArtistName, and EntryDate of all artists whose EntryDate is earlier than everyone who has a 'DirectMail' LeadSource.

SELECT ArtistID, ArtistName, EntryDate
FROM Artists
WHERE EntryDate < ALL (SELECT EntryDate
   					 FROM Artists
                    	WHERE LeadSource = 'DirectMail');
                        
-- Q3: List the ArtistID, ArtistName, and EntryDate of all artists whose EntryDate is earlier than anyone who has a 'DirectMail' LeadSource.

SELECT ArtistID, ArtistName, EntryDate
FROM Artists
WHERE EntryDate < ALL (SELECT EntryDate
   					 FROM Artists
                    	WHERE LeadSource = 'DirectMail');

-- Q4: List the ArtistName and EntryDate of the artist with the earliest entry date.

SELECT ArtistName, EntryDate
FROM Artists
WHERE EntryDate = ALL (SELECT MIN(EntryDate)
   					 FROM Artists);

-- Q5: List the TrackTitle of all tracks in the 'alternative' genre.

SELECT DISTINCT T.TrackTitle
From Tracks T, Titles Tr
Where T.TitleID = Tr.TitleID AND Genre = 'alternative';

                 
-- Q6: List all the unique genres from the `Genre` table that are not represented in the `Titles` table.

SELECT Genre
FROM Genre 
WHERE Genre NOT IN (
    SELECT DISTINCT Genre
    FROM Titles);
	
-- Q7: List the TrackTitle and length of tracks with a length longer than all tracks in the 'metal' genre. (Hint: This requires sub-query within a sub-query)

SELECT TrackTitle, LengthSeconds
FROM Tracks
WHERE LengthSeconds > ALL (SELECT LengthSeconds
   						 FROM Tracks
   						 WHERE TitleID IN (SELECT TitleID
   											 FROM Titles
   											 WHERE Genre = 'metal'));

-- Q8: List the TrackTitle of the track with the longest length.

SELECT TrackTitle
FROM Tracks
WHERE LengthSeconds = (SELECT MAX(LengthSeconds)
   						FROM Tracks);
                        
-- Q9: List the FirstName, LastName, and Birthday of the oldest member WITHOUT using MIN() function. (Hint: use a subquery and ALL)

SELECT FirstName, LastName, Birthday
FROM Members
WHERE Birthday <= ALL (SELECT Birthday
   					FROM Members);

-- Q10: List the FirstName, LastName, and Birthday of the second oldest member.

SELECT FirstName, LastName, Birthday
FROM Members M1
WHERE (
    SELECT COUNT( Birthday)
    FROM Members M2
    WHERE M2.Birthday <= M1.Birthday
)	= 2;

-- Q11: List the CD title and the TrackTitle of all tracks recorded in the studio with StudioID 1.

	-- Equi Join
		SELECT T.Title, Tr.TrackTitle
		FROM Titles T, Tracks Tr, Studios S
		WHERE T.TitleID = Tr.TitleID
		AND T.StudioID = S.StudioID
		AND S.StudioID = 1;

	-- Inner Join
		SELECT T.Title, Tr.TrackTitle
		FROM Titles T
		INNER JOIN Tracks Tr ON T.TitleID = Tr.TitleID
		INNER JOIN Studios S ON T.StudioID = S.StudioID
		WHERE S.StudioID = 1;

-- Q12: List each Title from the `Titles` table along with the name of the studio where it was recorded.

	-- Equi Join
		SELECT T.Title, S.StudioName
		FROM Titles T, Studios S
		WHERE T.StudioID = S.StudioID;

	-- Inner Join
		SELECT T.Title, S.StudioName
		FROM Titles T
		INNER JOIN Studios S ON T.StudioID = S.StudioID;

-- Q13: Find the name (including FirstName and LastName) of the salesperson who works with the member with last name 'Alvarez'.

	-- Equi Join
		SELECT SP.FirstName, SP.LastName
		FROM SalesPeople SP, Members M
		WHERE SP.SalesID = M.SalesID
		AND M.LastName = 'Alvarez';

	-- Inner Join
		SELECT SP.FirstName, SP.LastName
		FROM SalesPeople SP
		INNER JOIN Members M ON SP.SalesID = M.SalesID
		WHERE M.LastName = 'Alvarez';

-- Q14: List the name of members from California(CA) and their salespeople's name.

	-- Equi Join
		SELECT M.FirstName AS MemberFirstName, M.LastName AS MemberLastName, SP.FirstName AS SalesFirstName, SP.LastName AS SalesLastName
		FROM Members M, SalesPeople SP
		WHERE M.SalesID = SP.SalesID
		AND M.Region = 'CA';

	-- Inner Join
		SELECT M.FirstName AS MemberFirstName, M.LastName AS MemberLastName, SP.FirstName AS SalesFirstName, SP.LastName AS SalesLastName
		FROM Members M
		INNER JOIN SalesPeople SP ON M.SalesID = SP.SalesID
		WHERE M.Region = 'CA';

-- Q15: List the name of all artists who have recorded more than one CD titles and the number of titles they have.

	-- Equi Join
		SELECT A.ArtistName, COUNT(T.TitleID) AS NumberOfCDs
		FROM Artists A, Titles T
		WHERE A.ArtistID = T.ArtistID
		GROUP BY A.ArtistName
		HAVING COUNT(T.TitleID) > 1;

	-- Inner Join
		SELECT A.ArtistName, COUNT(T.TitleID) AS NumberOfCDs
		FROM Artists A
		INNER JOIN Titles T ON A.ArtistID = T.ArtistID
		GROUP BY A.ArtistName
		HAVING COUNT(T.TitleID) > 1;

-- Q16: List the CD title (i.e. `Title` field of `Titles` table) and the number of tracks (NOT `TrackNum` field) for any title with fewer than 9 tracks.

	-- Equi Join
		SELECT T.Title, COUNT(Tr.TrackTitle) AS NumberOfTracks
		FROM Titles T, Tracks Tr
		WHERE T.TitleID = Tr.TitleID
		GROUP BY T.Title
		HAVING COUNT(Tr.TrackTitle) < 9;

	-- Inner Join
		SELECT T.Title, COUNT(Tr.TrackTitle) AS NumberOfTracks
		FROM Titles T
		INNER JOIN Tracks Tr ON T.TitleID = Tr.TitleID
		GROUP BY T.Title
		HAVING COUNT(Tr.TrackTitle) < 9;