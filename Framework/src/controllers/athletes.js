var db = require("../db/database.js");

//GET - get all athletes in DB (Remove?)
exports.getAllAthletes = async(req, res) => {
  //console.log("Made it");
  try{
    db.query('SELECT * FROM Athletes', function (err, results, fields){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(results);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}

//GET - Search by Name
//Gets athlete and corresponding school
exports.getAthlete = async(req, res) => {
  try{
    console.log(req.params.name)
    db.query('SELECT A.AthleteID, A.Name as AthleteName, A.Gender, A.Grade, S.SchoolID, S.Name as SchoolName, S.Mascot, S.City, S.State FROM Athletes A, Schools S, (SELECT AT.SchoolID, AR.AthleteID FROM Athletes_Schools AT, (SELECT AthleteID FROM Athletes WHERE name LIKE "%"?"%") AR WHERE AR.AthleteID = AT.AthleteID) SA WHERE SA.AthleteID = A.AthleteID and SA.SchoolID = S.SchoolID'
      , [req.params.name], function (err, results, fields){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(results);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}

//GET - Get all of specific athletes results
//Gets athletes results
exports.getAthleteResults = async(req, res) => {
  try{
    console.log(req.params.results)
    db.query('SELECT R.*, E.Name as EventName FROM Events E, (SELECT M.MeetID, M.Name as MeetName, M.Day, M.Sport, R.ResultID, R.Position, R.TimeMark, R.DistanceMark, R.MarkString, R.PR, R.SR, R.Wind, R.SeasonYear, R.SeasonName, R.HandTime, R.Converted, R.MarkType, R.EventID FROM Meets M, (SELECT R.* FROM Results R, (SELECT A.AthleteID, AR.ResultID FROM Athletes_Results AR, (SELECT A.AthleteID FROM Athletes A WHERE AthleteID = ?) A WHERE A.AthleteID = AR.AthleteID) RA WHERE RA.ResultID = R.ResultID) R WHERE R.MeetID = M.MeetID) R WHERE R.EventID = E.EventID;'
      , [req.params.results], function (err, results, fields){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(results);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}

//GET - Get all of specific athletes best marks
//Gets athletes results
exports.getAthleteBests = async(req, res) => {
  try{
    console.log(req.params.bests)
    db.query('SELECT AM.ResultID, AM.MarkString, ZZ.TimeMark, ZZ.Name as EventName, ZZ.SeasonYear FROM (SELECT R.ResultID, R.TimeMark, R.MarkString, R.SeasonYear, E.Name FROM Results R, Events E, (SELECT A.AthleteID, AR.ResultID FROM Athletes_Results AR, Athletes A WHERE A.AthleteID = AR.AthleteID and A.AthleteID = ?) RA WHERE RA.ResultID = R.ResultID and R.EventID = E.EventID) AM, (SELECT MIN(AM.TimeMark) as TimeMark, AM.Name, AM.SeasonYear FROM (SELECT R.ResultID, R.TimeMark, R.MarkString, R.SeasonYear, E.Name FROM Results R, Events E, (SELECT A.AthleteID, AR.ResultID FROM Athletes_Results AR, Athletes A WHERE A.AthleteID = AR.AthleteID and A.AthleteID = ?) RA WHERE RA.ResultID = R.ResultID and R.EventID = E.EventID) AM WHERE AM.TimeMark > 0 GROUP BY AM.Name, AM.SeasonYear) ZZ WHERE ZZ.TimeMark = AM.TimeMark;'
      , [req.params.bests, req.params.bests], function (err, bests, fields){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(bests);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}


