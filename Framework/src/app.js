'use strict';

//Import Statements
var express = require('express');
var parser = require('body-parser');
var logger = require('morgan');
var errors = require('http-errors')
var bodyParser = require('body-parser');

const app = express();

//default get
app.get('/', (req, res) => {
    res.send("Local Host is up, How ya doin?");
});

//Link Routes
var athleteRouter = require('./routes/athletes');

//Configure Express
require('./db/database');
//app.use(parser.json());
//app.use(logger('dev'));

app.use('/athletes', athleteRouter);


// Configure Server to Listen on Port 3000
app.listen(3000, function(){
  console.log("The server is running on port 3000");
});

