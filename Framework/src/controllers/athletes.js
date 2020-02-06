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
exports.getAthlete = async(req, res) => {
  try{
    console.log(req.params.name)
    db.query('SELECT * FROM Athletes WHERE name LIKE "%"?"%"', [req.params.name], function (err, results, fields){
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







