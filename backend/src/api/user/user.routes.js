const express = require('express');
const userRounter = express.Router();

const user = require('./user.handlers');

userRounter.post('/login', user.login);

module.exports = userRounter;
