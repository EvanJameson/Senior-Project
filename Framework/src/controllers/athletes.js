var Athlete = require('../models/athlete');

//GET - get all athletes in DB (Remove?)
exports.getAllAthletes = async(req, res) => {
  try{
    Athlete.find({}, function(err, athletes){
    if(err) {
      return res.status(500).json({message: err.message});
    }
      res.json(athletes);
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
    //console.log(req.params.name)
    Athlete.find({"Athlete.Name": {$regex: req.params.name, $options: "i" }}, function(err, athlete){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(athlete);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}

//GET - Search by School
exports.getAthleteBySchool = async(req, res) => {
  try{
    console.log(req.params.school)
    Athlete.find({"Athlete.School": {$regex: req.params.school, $options: "i"}}, function(err, athlete){
      if(err) {
        return res.status(500).json({message: err.message});
      }
      res.json(athlete);
    });
  }
  catch(err) {
    console.log(err);
    res.send(404);
  }
}



