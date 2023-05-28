const { StatusCodes } = require('http-status-codes');
const models = require('../../models');
const { generateAPIError } = require('../../errors');

module.exports.createRequest = async (requestDetails, mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber });
  request.userId = user._id;
  const request = await models.Request.create(requestDetails);
  return request._id;
};
