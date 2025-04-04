-- Diego Barreras
-- Brian Gonzalez
-- Lab 06: Advanced Queries 

-- Q1: List the names of all artists who have not recorded a title. Use EXISTS.

SELECT ArtistName
FROM Artists A
WHERE NOT EXISTS (
    SELECT ArtistName
    FROM Titles T
    WHERE T.ArtistID = A.ArtistID);
    
-- Q2: Produce a single list of studio names with their web addresses and artist names with their web addresses.
--  Eliminate any studios or artists without a web address in the results.

SELECT StudioName AS 'Name' , WebAddress 
FROM Studios 
WHERE WebAddress IS NOT NULL
UNION 
SELECT ArtistName AS 'Name', WebAddress
FROM Artists 
WHERE WebAddress IS NOT NULL;

-- Q3: Report the number of female members, male members, and the total number.  Use proper column names.

SELECT Gender, COUNT(*) AS 'Counts'
FROM Members
GROUP BY Gender
UNION 
SELECT 'Total', COUNT(*)
FROM Members;

-- Q4: Report the number of artists who entered in the same year and the total number.(by adding a new row, ex) UNION). 

SELECT YEAR(EntryDate) AS "Year", COUNT(*) AS "Number of Artists"
FROM Artists
GROUP BY YEAR(EntryDate)
UNION 
SELECT 'Total', COUNT(*)
FROM Artists;

-- Q5: For each title id, report the number of sound files (if one track has both MP3 file and the RealAud file. then count them as 2).

SELECT DISTINCT T.TitleID, SoundFiles
FROM Tracks T INNER JOIN
(SELECT TitleID, Sum(MP3)+Sum(RealAud) AS SoundFiles
FROM Tracks GROUP BY TitleID) SC
on SC.TitleID = T.TitleID;

-- Q6: For TitleID 1, report the TitleID, track title, lengthseconds, the average lengthseconds for all tracks of 
-- TitleID 1, and the difference value between the lengthseconds and the average value.

SELECT T.TitleID, T.TrackTitle, T.LengthSeconds, AVG(Tr.LengthSeconds) AS AvgLengthSeconds, 
	   T.LengthSeconds - AVG(Tr.LengthSeconds) AS LengthSecondsDifference
FROM Tracks T
INNER JOIN Tracks Tr ON T.TitleID = Tr.TitleID
WHERE T.TitleID = 1
GROUP BY T.TitleID, T.TrackTitle, T.LengthSeconds;


-- Q7: For each title id, report the TitleID, track number, track title, lengthseconds, the average lengthseconds 
-- for all tracks of the TitleID, and the difference value between the lengthseconds and the average value.  
-- Use correlated sub-queries in the SELECT clause to answer the query.

SELECT T1.TitleID, T1.TrackNum, T1.TrackTitle,T1.LengthSeconds,
	(SELECT AVG(T2.LengthSeconds)
	FROM Tracks T2
	WHERE T2.TitleID = T1.TitleID) AS AvgLengthSeconds,
														T1.LengthSeconds - (SELECT AVG(T2.LengthSeconds)
														FROM Tracks T2
														WHERE T2.TitleID = T1.TitleID) AS LengthSecondsDifference
FROM Tracks T1
ORDER BY T1.TitleID, T1.TrackNum;

-- Q8: Re-design the query in Q7 using sub-queries in the FROM clause.

SELECT T1.TitleID, T1.TrackNum, T1.TrackTitle, T1.LengthSeconds, T2.AvgLengthSeconds, T1.LengthSeconds - T2.AvgLengthSeconds AS LengthSecondsDifference
FROM Tracks T1
JOIN (
    SELECT TitleID, AVG(LengthSeconds) AS AvgLengthSeconds
    FROM Tracks
    GROUP BY TitleID
) AS T2 ON T1.TitleID = T2.TitleID
ORDER BY T1.TitleID, T1.TrackNum;

-- Q9: Report the title name, number of tracks, and total time in minutes for each title.

SELECT T.Title AS TitleName, COUNT(Tr.TitleID) AS NumberOfTracks, Left(SUM(Tr.LengthSeconds) / 60, 2) AS TotalTimeMin
FROM Titles T
LEFT JOIN Tracks Tr ON T.TitleID = Tr.TitleID
GROUP BY T.Title, T.TitleID
ORDER BY T.TitleID;

-- Q10: Produce a list of all of the area codes used in both member's home phones and studio's phones along with 
-- a count of the phone numbers for each area code.

SELECT LEFT(HomePhone, 3) AS AreaCode, COUNT(*) AS Count
FROM Members
WHERE HomePhone IS NOT NULL 
GROUP BY LEFT(HomePhone, 3)
UNION ALL
SELECT LEFT(Phone, 3) AS AreaCode, COUNT(*) AS Count
FROM Studios
WHERE Phone IS NOT NULL
GROUP BY LEFT(Phone, 3);

-- Q11: For each artist, list the artist name and the first and last name (together in one column) of every member associated 
-- with that artist followed on the next line by a count of the number of members associated with that artist. Include all 
-- artists whether they have members or not. 

SELECT A.ArtistName,CONCAT(ML.MemberNames, '\n') AS MemberNames, ML.MemberCount AS MemberCount
FROM Artists A
LEFT JOIN (
    SELECT XAM.ArtistID, GROUP_CONCAT(CONCAT(M.FirstName, ' ', M.LastName) ORDER BY M.FirstName ASC SEPARATOR ', ') AS MemberNames, COUNT(*) AS MemberCount
    FROM XrefArtistsMembers XAM
    JOIN Members M 
    ON XAM.MemberID = M.MemberID
    GROUP BY XAM.ArtistID
) AS ML
ON A.ArtistID = ML.ArtistID
ORDER BY A.ArtistName;

-- Q12: Use a correlated sub-query and EXISTS to list all genres that do NOT have recorded titles.

SELECT DISTINCT G.Genre
FROM Genre G
WHERE NOT EXISTS (
    SELECT Genre
    FROM Titles T
    WHERE T.Genre = G.Genre);

-- Q13: List the artist id and the artist name of all artists who have members not in the USA.

SELECT A.ArtistID, A.ArtistName
FROM Artists A
WHERE A.ArtistID IN (
						SELECT X.ArtistID
						FROM XrefArtistsMembers X
						JOIN Members M ON X.MemberID = M.MemberID
						WHERE M.Country <> 'USA');
