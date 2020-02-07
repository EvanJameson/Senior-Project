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
    db.query('SELECT R.*, E.Name as EventName FROM Events E, (SELECT M.MeetID, M.Name as MeetName, M.Day, M.Sport, R.ResultID, R.Position, R.TimeMark, R.DistanceMarkInches, R.PR, R.SR, R.Wind, R.Season, R.HandTime, R.Converted, R.MarkType, R.EventID FROM Meets M, (SELECT R.* FROM Results R, (SELECT A.AthleteID, AR.ResultID FROM Athletes_Results AR, (SELECT A.AthleteID FROM Athletes A WHERE AthleteID = ?) A WHERE A.AthleteID = AR.AthleteID) RA WHERE RA.ResultID = R.ResultID) R WHERE R.MeetID = M.MeetID) R WHERE R.EventID = E.EventID;'
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



