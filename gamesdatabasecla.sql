DROP DATABASE IF EXISTS GamesDB;
CREATE DATABASE GamesDB;
USE GamesDB;

CREATE TABLE Coaches (
    Coach_ID INT PRIMARY KEY,
    Coach_Name VARCHAR(50) NOT NULL,
    Experience INT
);

CREATE TABLE Teams (
    Team_ID INT PRIMARY KEY,
    Team_Name VARCHAR(50) NOT NULL,
    Coach_ID INT,
    FOREIGN KEY (Coach_ID) REFERENCES Coaches(Coach_ID)
);

CREATE TABLE Players (
    Player_ID INT PRIMARY KEY,
    Player_Name VARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    Gender VARCHAR(10),
    Team_ID INT,
    FOREIGN KEY (Team_ID) REFERENCES Teams(Team_ID)
);

CREATE TABLE Games (
    Game_ID INT PRIMARY KEY,
    Game_Name VARCHAR(50) NOT NULL,
    Min_Age INT NOT NULL,
    Max_Age INT NOT NULL
);

CREATE TABLE Tournaments (
    Tournament_ID INT PRIMARY KEY,
    Tournament_Name VARCHAR(100) NOT NULL,
    Game_ID INT,
    Tournament_Date DATE,
    FOREIGN KEY (Game_ID) REFERENCES Games(Game_ID)
);

CREATE TABLE Player_Participation (
    Participation_ID INT PRIMARY KEY,
    Player_ID INT,
    Game_ID INT,
    Tournament_ID INT,
    Score INT,
    FOREIGN KEY (Player_ID) REFERENCES Players(Player_ID),
    FOREIGN KEY (Game_ID) REFERENCES Games(Game_ID),
    FOREIGN KEY (Tournament_ID) REFERENCES Tournaments(Tournament_ID)
);

INSERT INTO Coaches VALUES
(1, 'Ravi Kumar', 10),
(2, 'Suresh Reddy', 8),
(3, 'Anil Sharma', 12),
(4, 'Priya Singh', 7),
(5, 'Kiran Rao', 9);

INSERT INTO Teams VALUES
(101, 'Thunder Warriors', 1),
(102, 'Golden Eagles', 2),
(103, 'Red Strikers', 3),
(104, 'Blue Hawks', 4),
(105, 'Green Titans', 5);

INSERT INTO Players VALUES
(1, 'Arjun', 20, 'Male', 101),
(2, 'Rahul', 22, 'Male', 102),
(3, 'Sneha', 19, 'Female', 103),
(4, 'Priya', 24, 'Female', 104),
(5, 'Kiran', 18, 'Male', 105),
(6, 'Anjali', 21, 'Female', 101),
(7, 'Vijay', 26, 'Male', 102),
(8, 'Meena', 23, 'Female', 103);

INSERT INTO Games VALUES
(201, 'Football', 18, 30),
(202, 'Basketball', 18, 25),
(203, 'Cricket', 16, 35),
(204, 'Volleyball', 18, 28),
(205, 'Badminton', 16, 30);

INSERT INTO Tournaments VALUES
(301, 'National Football Cup', 201, '2026-01-15'),
(302, 'State Basketball League', 202, '2026-02-20'),
(303, 'National Cricket Cup', 203, '2026-03-10'),
(304, 'State Volleyball Championship', 204, '2026-04-05'),
(305, 'National Badminton Open', 205, '2026-05-12');

INSERT INTO Player_Participation VALUES
(1, 1, 201, 301, 92),
(2, 2, 202, 302, 88),
(3, 3, 203, 303, 95),
(4, 4, 204, 304, 78),
(5, 5, 205, 305, 85),
(6, 6, 201, 301, 90),
(7, 7, 203, 303, 98),
(8, 8, 205, 305, 82),
(9, 1, 203, 303, 91),
(10, 2, 201, 301, 86);

SELECT * FROM Coaches;
SELECT * FROM Teams;
SELECT * FROM Players;
SELECT * FROM Games;
SELECT * FROM Tournaments;
SELECT * FROM Player_Participation;

SELECT
    P.Player_ID,
    P.Player_Name,
    P.Age,
    T.Team_Name
FROM Players P
INNER JOIN Teams T
ON P.Team_ID = T.Team_ID;

SELECT
    P.Player_Name,
    T.Team_Name,
    C.Coach_Name
FROM Players P
INNER JOIN Teams T
ON P.Team_ID = T.Team_ID
INNER JOIN Coaches C
ON T.Coach_ID = C.Coach_ID;

SELECT
    P.Player_Name,
    G.Game_Name,
    PP.Score
FROM Players P
INNER JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
INNER JOIN Games G
ON PP.Game_ID = G.Game_ID;

SELECT
    P.Player_Name,
    P.Age,
    T.Team_Name,
    C.Coach_Name,
    G.Game_Name,
    TR.Tournament_Name,
    PP.Score
FROM Players P
INNER JOIN Teams T
ON P.Team_ID = T.Team_ID
INNER JOIN Coaches C
ON T.Coach_ID = C.Coach_ID
INNER JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
INNER JOIN Games G
ON PP.Game_ID = G.Game_ID
INNER JOIN Tournaments TR
ON PP.Tournament_ID = TR.Tournament_ID;

SELECT P.Player_Name
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
WHERE PP.Game_ID = 201
UNION
SELECT P.Player_Name
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
WHERE PP.Game_ID = 203;

SELECT P.Player_Name
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
WHERE PP.Game_ID = 201
UNION ALL
SELECT P.Player_Name
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
WHERE PP.Game_ID = 203;

SELECT P.Player_Name
FROM Players P
WHERE EXISTS (
    SELECT 1
    FROM Player_Participation PP
    WHERE PP.Player_ID = P.Player_ID
    AND PP.Game_ID = 201
)
AND EXISTS (
    SELECT 1
    FROM Player_Participation PP
    WHERE PP.Player_ID = P.Player_ID
    AND PP.Game_ID = 203
);

SELECT P.Player_Name
FROM Players P
WHERE EXISTS (
    SELECT 1
    FROM Player_Participation PP
    WHERE PP.Player_ID = P.Player_ID
    AND PP.Game_ID = 201
)
AND NOT EXISTS (
    SELECT 1
    FROM Player_Participation PP
    WHERE PP.Player_ID = P.Player_ID
    AND PP.Game_ID = 203
);

SELECT
    P.Player_ID,
    P.Player_Name,
    P.Age,
    G.Game_Name,
    G.Min_Age,
    G.Max_Age,
    CASE
        WHEN P.Age BETWEEN G.Min_Age AND G.Max_Age
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility
FROM Players P
CROSS JOIN Games G;

SELECT
    P.Player_Name,
    P.Age,
    G.Game_Name,
    G.Min_Age,
    G.Max_Age,
    CASE
        WHEN P.Age BETWEEN G.Min_Age AND G.Max_Age
        THEN 'Eligible'
        ELSE 'Not Eligible'
    END AS Eligibility
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
JOIN Games G
ON PP.Game_ID = G.Game_ID;

SELECT
    P.Player_ID,
    P.Player_Name,
    SUM(PP.Score) AS Total_Score
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
GROUP BY P.Player_ID, P.Player_Name
ORDER BY Total_Score DESC
LIMIT 5;

SELECT
    Player_ID,
    Player_Name,
    Age,
    Gender
FROM Players
ORDER BY Age DESC
LIMIT 5;

CREATE VIEW Top_5_Players_By_Score AS
SELECT
    P.Player_ID,
    P.Player_Name,
    SUM(PP.Score) AS Total_Score
FROM Players P
JOIN Player_Participation PP
ON P.Player_ID = PP.Player_ID
GROUP BY P.Player_ID, P.Player_Name
ORDER BY Total_Score DESC
LIMIT 5;

SELECT * FROM Top_5_Players_By_Score;

CREATE VIEW Top_5_Players_By_Age AS
SELECT
    Player_ID,
    Player_Name,
    Age,
    Gender
FROM Players
ORDER BY Age DESC
LIMIT 5;
SELECT * FROM Top_5_Players_By_Age;
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

DESC Coaches;
DESC Teams;
DESC Players;
DESC Games;
DESC Tournaments;
DESC Player_Participation;