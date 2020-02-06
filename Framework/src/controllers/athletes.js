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

// //GET - Search by Name
// exports.getAthlete = async(req, res) => {
//   try{
//     console.log(req.params.name)
//     db.query('SELECT * FROM Athletes WHERE name LIKE "%"?"%"', [req.params.name], function (err, results, fields){
//       if(err) {
//         return res.status(500).json({message: err.message});
//       }
//       res.json(results);
//     });
//   }
//   catch(err) {
//     console.log(err);
//     res.send(404);
//   }
// }


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




