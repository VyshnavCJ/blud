const express = require('express');
const requestRouter = express.Router();

const request = require('./request.handlers');
const { auth } = require('../../middleware');
requestRouter.post('/create', auth('general'), request.create);
// requestRouter.get('/accept', auth('general'), request.accept);
// requestRouter.get('/view', auth('general'), request.view);
// requestRouter.get('/complete', auth('general'), request.complete);
// requestRouter.get('/cancel', auth('general'), request.cancel);
module.exports = requestRouter;
