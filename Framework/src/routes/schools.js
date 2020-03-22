'use strict';

// Import Express
var express = require('express');
var schoolController = require('../controllers/schools')

var schoolRouter = express.Router();

schoolRouter.get('/:name', schoolController.getSchool);

module.exports = schoolRouter;
