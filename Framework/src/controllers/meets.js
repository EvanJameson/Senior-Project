var db = require("../db/database.js");

//GET - Search by Meet
exports.getMeet = async(req, res) => {
  try{
    console.log(req.params.meet)
    db.query('SELECT * FROM Meets WHERE name LIKE "%"?"%"', [req.params.name], function (err, results, fields){
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
