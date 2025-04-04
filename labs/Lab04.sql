-- Group #4
-- Diego Barreras
-- Brian Gonzalez
-- Lab 04 

-- Q1:   List the name of the artist who recorded the track title 'Front Door'.

SELECT A.ArtistName
FROM Artists A
INNER JOIN Titles B ON A.ArtistID = B.ArtistID
INNER JOIN Tracks R ON R.TitleId = B.TitleID
WHERE R.TrackTitle = 'Front Door';

-- Q2:   Report the names of all artists that came from the leadsource e-mail and that have not recorded a title.

Select A.ArtistName
FROM Artists A
LEFT JOIN Titles T ON A.ArtistID = T.ArtistID
WHERE A.LeadSource = 'Email' AND T.Title IS NULL;

-- Q3:   List the names of all artists and a count of the number of members (if any) assigned to that artist. (use outer join)

Select A.ArtistName, count(MemberID)
FROM Artists A
LEFT JOIN XrefArtistsMembers X ON A.ArtistID = X.ArtistID
GROUP BY A.ArtistName;

-- Q4:   List the names of all artists and the StudioID (if any) they worked in. (use outer join)

Select DISTINCT A.ArtistName, StudioID
FROM Artists A
LEFT JOIN Titles T ON A.ArtistID = T.ArtistID
WHERE StudioID IS NOT NULL
ORDER BY A.ArtistName;

-- Q5:  List the names of all salespeople and a count of the number of members they work with. (use outer join)

Select S.FirstName, count(MemberID)
FROM SalesPeople S
LEFT JOIN Members M ON S.SalesID = M.SalesID
GROUP BY S.FirstName;

-- Q6:   Each member is given his or her salesperson as a primary contact name and also the name of that salesperson's supervisor as a secondary contact name. 
-- Produce a list of member names and the primary and secondary contacts for each.

SELECT M.FirstName AS MemberName, 
       SP.FirstName AS PrimaryContactFirstName,
       SP.LastName AS PrimaryContactLastName,
       SPS.FirstName AS SecondaryContactFirstName,
       SPS.LastName AS SecondaryContactLastName
FROM Members M
INNER JOIN SalesPeople SP ON M.SalesID = SP.SalesID
INNER JOIN SalesPeople SPS ON SP.Supervisor = SPS.SalesID;

-- Q7:   List any salesperson whose supervisor is supervised by no one. (use outer join)

SELECT *
FROM SalesPeople SP
RIGHT JOIN SalesPeople SPS ON SP.Supervisor = SPS.SalesID
WHERE SPS.Supervisor IS NULL;

-- Q8:   List the names of members with the Artist name of 'Highlander'.

SELECT M.FirstName, M.LastName
FROM Members M
INNER JOIN XrefArtistsMembers AM 
ON M.MemberID = AM.MemberID
INNER JOIN Artists A 
ON AM.ArtistID = A.ArtistID
WHERE A.ArtistName = 'Highlander';

-- Q9:   List each title from the Title table along with the name of the studio where it was recorded, the name of the artist, 
-- and the number of tracks on the title.

SELECT T.Title, S.StudioName, A.ArtistName, COUNT(TR.TrackNum) AS 'Number Of Tracks'
FROM Titles T
LEFT JOIN Studios S 
ON T.StudioID = S.StudioID
LEFT JOIN Artists A 
ON T.ArtistID = A.ArtistID
LEFT JOIN Tracks TR 
ON T.TitleID = TR.TitleID
GROUP BY T.Title, S.StudioName, A.ArtistName;

-- Q10: List all genres from the Genre table that are not represented in the Titles table. (use outer join)

SELECT G.Genre
FROM Genre G
LEFT JOIN Titles T ON G.Genre = T.Genre
WHERE T.Title IS NULL;

-- Q11:  List each genre from the genre table and the total length in minutes of all tracks recorded for that genre if any.  (use outer join)

SELECT G.Genre, SUM(TR.LengthSeconds) / 60.0 AS TotalLengthMinutes
FROM Genre G
LEFT JOIN Titles T ON G.Genre = T.Genre
LEFT JOIN Tracks TR ON T.TitleID = TR.TitleID
WHERE LengthSeconds IS NOT NULL
GROUP BY G.Genre;

-- Q12:   List the names of responsible parties along with the artist name of the artist they are responsible for.

SELECT M.FirstName, M.LastName, A.ArtistName AS ResponsibleFor
FROM Members M
INNER JOIN XrefArtistsMembers AM
ON M.MemberID = AM.MemberID
INNER JOIN Artists A 
ON AM.ArtistID = A.ArtistID;
