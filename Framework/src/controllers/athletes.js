//var Athlete = require('../models/athlete');

//var ResultsDB = require(../db);
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
exports.getAthleteByName = async(req, res) => {
  try{
    console.log(req.params.name)
    db.query('SELECT * FROM Athletes WHERE name=?', [req.params.name], function (err, results, fields){
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

//GET - Search by School
// exports.getAthleteBySchool = async(req, res) => {
//   try{
//     console.log(req.params.school)
//     Athlete.find({"Athlete.School": {$regex: req.params.school, $options: "i"}}, function(err, athlete){
//       if(err) {
//         return res.status(500).json({message: err.message});
//       }
//       res.json(athlete);
//     });
//   }
//   catch(err) {
//     console.log(err);
//     res.send(404);
//   }
// }



