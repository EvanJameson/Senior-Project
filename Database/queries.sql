# Queries to test data

SELECT * FROM Results;
SELECT * FROM Athletes;
SELECT * FROM Schools;
SELECT * FROM Meets;
SELECT * FROM Events;
SELECT * FROM Athletes_Results;
SELECT * FROM Athletes_Schools;
SELECT * FROM Meets_Schools;

#Get results for a specific athlete as well as meet
SELECT R.*, E.Name as EventName FROM Events E,
(SELECT M.MeetID, M.Name as MeetName, M.Day, M.Sport, R.ResultID, R.Position, R.TimeMark, R.DistanceMarkInches, R.PR, R.SR, R.Wind, R.Season, R.HandTime, R.Converted, R.MarkType, R.EventID FROM Meets M,
(SELECT R.* FROM Results R,
(SELECT A.AthleteID, AR.ResultID FROM Athletes_Results AR,
(SELECT A.AthleteID FROM Athletes A WHERE AthleteID = 1) A
  WHERE A.AthleteID = AR.AthleteID) RA
    WHERE RA.ResultID = R.ResultID) R
WHERE R.MeetID = M.MeetID) R
WHERE R.EventID = E.EventID;

#Gets athlete and school data based on partial name match
SELECT A.AthleteID, A.Name as AthleteName, A.Gender, A.Grade, S.SchoolID, S.Name as SchoolName, S.Mascot, S.City, S.State FROM Athletes A, Schools S,
(SELECT AT.SchoolID, AR.AthleteID FROM Athletes_Schools AT,
	(SELECT AthleteID FROM Athletes WHERE name LIKE "%Matthew%") AR
    WHERE AR.AthleteID = AT.AthleteID) SA
    WHERE SA.AthleteID = A.AthleteID and SA.SchoolID = S.SchoolID
    ;


INSERT INTO RESULTS (Position, TimeMark, DistanceMarkInches, Pr, Sr, Wind, Sport, Season, HandTime, Converted, MarkType, EventID, MeetID) VALUES (2, 6.68, 0, False, False, 0, "TF", "2020 Indoor Season", False, False, "LEGAL", 2, 1);
INSERT INTO Events (Name) VALUES ("100 Meters");

SELECT Name, COUNT(*)
FROM Events
WHERE Name = "100 Meters"
GROUP BY Name;

# Check Meet and school, need to look for ones that also visit meet
SELECT C.*
FROM
	(SELECT  M.MeetID as mid, COUNT(MS.MeetID) as Num_Schools
	FROM Schools S, Meets M, Meets_Schools MS
	WHERE S.SchoolID = MS.SchoolID and MS.MeetID = M.MeetID
	GROUP BY M.MeetID
	ORDER BY Num_Schools) C
WHERE C.Num_Schools > 0
;

# Check athlete and meet
#SELECT M.*
#FROM Results_Meets RM, Meets M,
#  (SELECT R.ResultID
#  FROM Results R, Athletes A, Athletes_Results AR
#  WHERE A.AthleteID = AR.AthleteID and R.ResultID = AR.ResultID and A.Name = "Matthew Boling") MR
#WHERE RM.ResultID = MR.ResultID and M.MeetID = RM.MeetID;

# Check athlete and school
SELECT A.name, S.*
FROM Athletes A, Schools S, Athletes_Schools ASS
WHERE A.AthleteID = ASS.AthleteID and S.SchoolID = ASS.SchoolID;

# Check athlete and school
SELECT A.AthleteID
FROM Athletes A, Schools S, Athletes_Schools ASS
WHERE A.AthleteID = ASS.AthleteID and S.SchoolID = ASS.SchoolID and A.Name = "Dorien Simon" and A.Grade = "12" and S.Name = "Unattached";

# Check athlete and result
SELECT A.Name , R.* #R.ResultID, R.TimeMark, R.DistanceMarkInches
FROM Results R, Athletes A, Athletes_Results AR
WHERE A.AthleteID = AR.AthleteID and R.ResultID = AR.ResultID and A.AthleteID = 149;

INSERT INTO Results (Position, TimeMark, DistanceMarkInches, Pr, Sr, Wind, Sport, Season)
VALUES (1, '00:00:10.430','0',True, False, 1.0, 'tf', 'blah');

SHOW TABLES;
