-- Diego Barreras
-- Brian Gonzalez

-- Lab 10: Triggers

-- SETUP Q1

CREATE TABLE Members_audit (
	id INT AUTO_INCREMENT PRIMARY KEY,
	memberID INT(11) NOT NULL,
	firstname VARCHAR(25) NOT NULL,
	lastname VARCHAR(25) NOT NULL,
	changedat DATETIME DEFAULT NULL,
	action VARCHAR(25) DEFAULT 'UPDATE');
    
-- SETUP Q2
CREATE TABLE Titles_Total (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ArtistID INT(11) NOT NULL,
    total INT NOT NULL,
    action VARCHAR(25) DEFAULT 'INSERT');
DELIMITER //
CREATE TRIGGER before_titles_insert
BEFORE INSERT ON Titles
FOR EACH ROW
BEGIN
    DECLARE artist_count INT;
    SELECT COUNT(*) INTO artist_count
    FROM Titles
    WHERE ArtistID = NEW.ArtistID;
    IF artist_count = 0 THEN
        INSERT INTO Titles_Total(ArtistID, total, action)
        VALUES (NEW.ArtistID, 1, 'INSERT');
    ELSE
        UPDATE Titles_Total
        SET total = total + 1, action = 'UPDATE'
        WHERE ArtistID = NEW.ArtistID;
    END IF;
END //
DELIMITER ;

INSERT INTO Titles_Total(ArtistID, total)
SELECT ArtistID, COUNT(*)
FROM Titles
GROUP BY ArtistID;

-- SETUP Q3

CREATE TABLE Artist_Welcome(
	id INT AUTO_INCREMENT primary key,
	artistName TEXT,
	message TEXT NOT NULL
);
