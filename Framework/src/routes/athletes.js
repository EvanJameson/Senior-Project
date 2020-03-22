'use strict';

// Import Express
var express = require('express');
var athleteController = require('../controllers/athletes')

var athleteRouter = express.Router();

//GET Route - fetches ALL Athletes
athleteRouter.get('/all', athleteController.getAllAthletes);
athleteRouter.get('/:name', athleteController.getAthlete);
athleteRouter.get('/results/:results', athleteController.getAthleteResults)
athleteRouter.get('/bests/:bests', athleteController.getAthleteBests)

module.exports = athleteRouter;

