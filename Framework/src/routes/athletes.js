'use strict';

// Import Express
var express = require('express');
var athleteController = require('../controllers/athletes')

var athleteRouter = express.Router();

//GET Route - fetches ALL Athletes
athleteRouter.get('/all', athleteController.getAllAthletes);
athleteRouter.get('/name/:name', athleteController.getAthleteByName);
//change to get param syntax
//athleteRouter.get('/school/:school', athleteController.getAthleteBySchool);

module.exports = athleteRouter;

