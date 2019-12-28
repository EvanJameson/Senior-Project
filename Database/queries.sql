# Queries to test data

SELECT * FROM Results;
SELECT * FROM Athletes;
SELECT * FROM Schools;
SELECT * FROM Meets;
SELECT * FROM Athletes_Results;
SELECT * FROM Results_Meets;

# Check athlete and meet
SELECT M.*
FROM Results_Meets RM, Meets M,
  (SELECT R.ResultID
  FROM Results R, Athletes A, Athletes_Results AR
  WHERE A.AthleteID = AR.AthleteID and R.ResultID = AR.ResultID and A.Name = "Matthew Boling") MR
WHERE RM.ResultID = MR.ResultID and M.MeetID = RM.MeetID;

# Check athlete and school
SELECT A.name, S.*
FROM Athletes A, Schools S, Athletes_Schools ASS
WHERE A.AthleteID = ASS.AthleteID and S.SchoolID = ASS.SchoolID;

# Check athlete and result
SELECT A.Name , R.* #R.ResultID, R.TimeMark, R.DistanceMarkInches
FROM Results R, Athletes A, Athletes_Results AR
WHERE A.AthleteID = AR.AthleteID and R.ResultID = AR.ResultID and A.AthleteID = 1;

INSERT INTO Results (Position, TimeMark, DistanceMarkInches, Pr, Sr, Wind, Sport, Season)
VALUES (1, '00:00:10.430','0',True, False, 1.0, 'tf', 'blah');

SHOW TABLES;
