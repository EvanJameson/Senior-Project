'use strict';

var mysql = require('mysql')
var connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '*localpass',
  database: 'resultsDB'
  }
)

connection.connect(function (err) {
  if(err) {
      console.log('Failed connecting to MySQL.\n' + err.sqlMessage);
    }
    else {
      console.log('Successfully connected to MySQL!');
    }
});

module.exports = connection

//connection.end()
