const { StatusCodes } = require('http-status-codes');
const jwt = require('jsonwebtoken');
const { generateAPIError } = require('../errors');
const models = require('../models');


module.exports.auth = (type) => {
  return async (req, res, next) => {
    // check header
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer'))
      return next(generateAPIError('Authentication invalid', 401));

    const token = authHeader.split(' ')[1];

    if (!token) {
      next({ status: 403, message: 'auth token is missing' });
      return;
    }

    try {
      const payload = jwt.verify(token, process.env.JWT_SECRET);
      // attach the user to the job routes
      req.user = payload.payload;

      if (type !== 'otp' && 'otp' in req.user)
        return next(generateAPIError('Authentication invalid', 401));

      if ('mobileNumber' in req.user) {
        const user = await models.User.findOne({
          mobileNumber: payload.payload.mobileNumber
        });

        if (type === 'general' && !user)
          return next(generateAPIError('Authentication invalid', 401));
      } else return next(generateAPIError('Authentication invalid', 401));

      next();
    } catch (error) {
      return next(generateAPIError('Authentication invalid', 401));
    }
  };
};
