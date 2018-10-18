const express = require('express');
const morgan = require('morgan');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();

// Database Setup
mongoose.connect('mongodb://mongo:27017/spotifySignIn', { useMongoClient: true }, function (err) {
  console.log('connected');
});
mongoose.connection.on('error', function(err) {
  console.error(`MongoDB connection error: ${err}`);
  process.exit(-1); // eslint-disable-line no-process-exit
});

// middleware
app.use(morgan('dev'));
app.use(bodyParser.json());

// routes
app.use('/auth', require('./auth'));

var port = process.env.PORT || 9000
app.listen(port function () {
  console.log(`Example app listening on ${port} !`)
});

module.exports = app;
