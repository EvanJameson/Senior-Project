'use strict';

// Import Express
var express = require('express');
var meetController = require('../controllers/meets')

var meetRouter = express.Router();

meetRouter.get('/:name', meetController.getMeet);

module.exports = meetRouter;
