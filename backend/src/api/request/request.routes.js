const express = require('express');
const requestRouter = express.Router();

const request = require('./request.handlers');
const { auth } = require('../../middleware');
requestRouter.post('/create', auth('general'), request.create);
requestRouter
  .route('/meta_wa_callbackurl')
  .get(request.whatsappVerify)
  .post(request.whatsappRecieve);
requestRouter.get('/view', auth('general'), request.view);
requestRouter.post('/accept', auth('general'), request.accept);
requestRouter.post('/complete', auth('general'), request.complete);
requestRouter.delete('/cancel', auth('general'), request.cancel);
module.exports = requestRouter;
