-- Group 4 


-- Brian Gonzalez

-- Diego Barreras


-- Lab 5

-- Q1: For each member, report the member name and home phone number. Concatenate the first and last name of each member with a whitespace between.
	Select CONCAT(FirstName, ' ', HomePhone) AS 'First Name and Phone #'
	FROM Members;

-- Q2: For each member, report the member name and the age of the member.

	SELECT CONCAT_WS(' ', FirstName, LastName) AS Name, FLOOR(DATEDIFF(NOW(), Birthday) / 365) AS Age
	FROM Members;

-- Q3: Report the studio name and the first name of each studio contact. Hint: the first name is the part before the space.

	SELECT LEFT(Contact, LOCATE(' ', Contact)-1)
	FROM Studios;

-- Q4: Report the studio name and the last name of each studio contact. Hint: the last name is the part that follows the space.

	SELECT StudioName AS 'Studio Name', SUBSTRING_INDEX(Contact, ' ', -1) AS 'Contact Last Name'
	FROM Studios;

-- Q5: Report the track title with the most characters.

	SELECT TrackTitle, Length(TrackTitle)
	FROM Tracks
	WHERE Length(TrackTitle) = (SELECT MAX(Length(TrackTitle))
								FROM Tracks);
                         
-- Q6:  List every genre from the Genre table and the names of any titles in that genre if any. For any genre without titles, display 
-- 'No Titles' in the Title column.

	SELECT G.Genre, IFNULL(T.Title, 'No Titles') AS Title
	FROM Genre G
	LEFT JOIN Titles T ON G.Genre = T.Genre;

-- Q7: Report all the genres from the Genre table. Capitalize the first letter of each genre and the rest of the letters should be lower case.

	SELECT concat(UPPER(SUBSTRING(Genre, 1, 1)), SUBSTRING(Genre, 2, Length(Genre))) AS Genre
	FROM Genre;

-- Q8: Redo Q6 using CASE.

	SELECT G.Genre, 
		CASE 
			WHEN T.Title IS NULL THEN 'No Titles'
			ELSE T.Title
		END AS Title
	FROM Genre G
	LEFT JOIN Titles T ON G.Genre = T.Genre;
    
-- Q9: List each artist name and a lead source designation. If the lead source is 'Ad',
-- then report 'Ad' for the lead source designation. If the lead source is anything else, then report 'Not Ad' for the lead source designation.

	SELECT ArtistName,
	Case LeadSource
		When 'Ad' Then 'Ad'
		ELSE 'Not Ad'
	End AS LeadSource
	FROM Artists;

-- Q10: Report the artist name and the age in years of the responsible member for each artist at the time of that artist's entry date.

	SELECT A.ArtistName AS 'Artist Name',
		(YEAR(A.EntryDate) - YEAR(M.Birthday)) -
        (CASE
			WHEN DATE_FORMAT(A.EntryDate, '%m-%d') < DATE_FORMAT(M.Birthday, '%m-%d') THEN 1
			ELSE 0
		END) AS 'Age At Entry Date'
	FROM Artists A
	JOIN XrefArtistsMembers X 
    ON A.ArtistID = X.ArtistID
	JOIN Members M 
    ON X.MemberID = M.MemberID;