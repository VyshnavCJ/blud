const { StatusCodes } = require('http-status-codes');
const models = require('../../models');
const { generateAPIError } = require('../../errors');
const { getAcceptableBloodGroups } = require('../../utils');
const {
  getResponse,
  setResponse,
  calculateDistance
} = require('./request.helpers');

module.exports.createRequest = async (requestDetails, mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber });
  requestDetails.userId = user._id;
  const request = await models.Request.create(requestDetails);
  return request._id;
};
module.exports.findDonors = async (requestId, range) => {
  const request = await models.Request.findById(requestId);
  const bg = getAcceptableBloodGroups(request.bloodGroup);
  const lng = request.location.coordinates[0];
  const lat = request.location.coordinates[1];
  const maxdistance = range + 35000;
  const pd = await models.User.find({
    $and: [
      { bloodGroup: { $in: bg } },
      {
        location: {
          $near: {
            $geometry: {
              type: 'Point',
              coordinates: [parseFloat(lng), parseFloat(lat)]
            },
            $maxDistance: maxdistance
          }
        }
      }
    ]
  })
    .select('-location')
    .lean();

  return pd;
};
module.exports.createResponse = async (fpd, id) => {
  await setResponse(fpd, id);
  return id;
};
