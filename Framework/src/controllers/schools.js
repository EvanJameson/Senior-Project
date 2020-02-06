var db = require("../db/database.js");


//GET - Search by School
exports.getSchool = async(req, res) => {
  try{
    console.log(req.params.school)
    db.query('SELECT * FROM Schools WHERE name LIKE "%"?"%"', [req.params.name], function (err, results, fields){
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
