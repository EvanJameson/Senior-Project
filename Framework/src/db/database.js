'use strict';

var mongoose = require('mongoose');

const host = 'localhost';

const projectName = 'AthleteDB';

mongoose.connect('mongodb://' + host + '/' + projectName, {
   useNewUrlParser: true,
   useUnifiedTopology: true
 }, function(err) {
  if(err) {
    console.log('Failed connecting to MongoDB.');
  }
  else {
    console.log('Successfully connected to MongoDB!');
  }
});

