const express = require('express');
const requestRouter = express.Router();

const request = require('./request.handlers');
const { auth } = require('../../middleware');
requestRouter.post('/create', auth('general'), request.create);
requestRouter.post('/available', auth('general'), request.view);
module.exports = requestRouter;
