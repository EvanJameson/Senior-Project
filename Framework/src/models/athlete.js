'use strict';

var mongoose = require('mongoose');

// Create the Schema
//
// Having the athlete wrapper keeps necessary data
var athleteSchema = new mongoose.Schema({
  Athlete: {
    Name: String,
    School: String,
    Grade: String,
    TF:{
      records: [
        {
          event: String,
          marks: [
            {
              year: String,
              mark: String
            }
          ]
        }
      ],
      results: [
        {
          season: String,
          events: [
            {
              event: String,
              meets: [
                {
                  meet: String,
                  marks: [
                    {
                      pos: String,
                      mark: String,
                      date: String,
                      wind: String,
                      pr: Boolean,
                      sr: Boolean
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  }
},{ collection: 'athletes'}, {strict: false});
//TODO: Define Schema for School index

//TODO: Define Schema for Meet index

// Build the Model
var model = mongoose.model('Athlete', athleteSchema);

// Export the Model
module.exports = model;

