const express = require('express');
const userRouter = express.Router();
const user = require('./user.handlers');
const { auth } = require('../../middleware');

userRouter.post('/login', user.login);
userRouter.post('/auth', auth('otp'), user.auth);
userRouter.post('/create', auth('create'), user.create);
userRouter.get('/home', auth('general'), user.home);
userRouter.get('/history/:id', auth('general'), user.history);
userRouter
  .route('/profile')
  .get(auth('general'), user.view)
  .patch(auth('general'), user.edit);

module.exports = userRouter;
