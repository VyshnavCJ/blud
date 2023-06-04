const { StatusCodes } = require('http-status-codes');
const models = require('../../models');
const { generateAPIError } = require('../../errors');
const {
  getAcceptableBloodGroups,
  Whatsapp,
  getDonatableBloodGroups
} = require('../../utils');
const {
  setResponse,
  calculateDistance,
  deleteResponse,
  getResponse
} = require('./request.helpers');
var mongoose = require('mongoose');
module.exports.createRequest = async (requestDetails, mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber });
  requestDetails.userId = user._id;
  const request = await models.Request.create(requestDetails);
  return request;
};
module.exports.findDonors = async (request) => {
  const bg = getAcceptableBloodGroups(request.bloodGroup);
  const lng = request.location.coordinates[0];
  const lat = request.location.coordinates[1];
  const maxdistance = request.range + 35000;
  const pd = await models.User.find({
    $and: [
      { active: true },
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
    .select('name location mobileNumber bloodGroup')
    .lean();

  return pd;
};
module.exports.createResponse = async (pd, requestId) => {
  await setResponse(pd, requestId, false, 0);
};

module.exports.sendWhatsapp = async (request, numbers) => {
  let x = request.time;
  let hr = Math.trunc(x / 100);
  let min = x % 100;
  let time = '';
  if (hr > 12) time = hr - 12 + ':' + min + ' PM';
  else time = hr + ':' + min + ' AM';
  const template = `Blud  BLOOD CELL🛑\n

🩸 BLOOD REQUIREMENT🩸\n

Blood group  :  ${request.bloodGroup}\n
Name of person : ${request.name}\n
Date : ${request.date.toDateString()}\n
Bleeding  Time : ${time}\n
Bleeding  Place : ${request?.bleedingPlace}\n
Hospital  : ${request?.hospital}, pincode ${request?.pinCode}\n
Bystander Name: ${request?.bystander}\n
No of units : ${request?.units}\n
Case : ${request.case}`;

  await Whatsapp.sendSimpleButtons({
    message: template,
    recipientPhone: [917306255230],
    listOfButtons: [
      {
        title: 'Yes',
        id: request._id
      },
      {
        title: 'No',
        id: 'null'
      }
    ]
  });
};
module.exports.updateResponse = async (requestId, number) => {
  requestId = mongoose.Types.ObjectId(requestId);
  const requestLoc = await models.Request.findById(requestId).select(
    'location'
  );
  const accepter = await models.User.findOne({
    mobileNumber: number
  });
  const distance = calculateDistance(
    requestLoc.location.coordinates[1],
    requestLoc.location.coordinates[0],
    accepter.location.coordinates[1],
    accepter.location.coordinates[0]
  );
  accepter.active = false;
  await accepter.save();
  await setResponse([accepter], requestId, true, distance);
};
module.exports.getRequest = async (mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber });
  const bg = getDonatableBloodGroups(user.bloodGroup);
  const lng = user.location.coordinates[0];
  const lat = user.location.coordinates[1];
  const maxdistance = 35000;
  const rd = await models.Request.aggregate([
    {
      $geoNear: {
        near: {
          type: 'Point',
          coordinates: [parseFloat(lng), parseFloat(lat)]
        },
        distanceField: 'distance',
        maxDistance: maxdistance,
        spherical: true,
        key: 'location',
        distanceMultiplier: 0.001
      }
    },
    {
      $match: {
        $and: [{ isActiveRequest: true }, { bloodGroup: { $in: bg } }]
      }
    },
    {
      $project: {
        name: 1,
        bloodGroup: 1,
        hospital: 1,
        units: 1,
        pinCode: 1,
        distance: 1
      }
    }
  ]);
  return rd;
};
module.exports.updateRequest = async (requestId, donorNumber) => {
  const donor = await models.User.findOne({ mobileNumber: donorNumber });
  donor.active = false;
  donor.lastActive = new Date();
  const request = await models.Request.findById(requestId);
  request.donorId = donor._id;
  request.isActiveRequest = false;
  request.donatedDate = new Date();
  await donor.save();
  await request.save();
  await deleteResponse(requestId);
};
module.exports.dropResponse = async (requestId) => {
  const response = await getResponse(requestId);
  let numbers = [];
  for (const key in response) {
    if (response[key].accept == true) numbers.push(key);
  }
  await deleteResponse(requestId);
  return numbers;
};
module.exports.dropRequest = async (id) => {
  await models.Request.deleteOne({ _id: id });
};
module.exports.updateUser = async (numbers) => {
  console.log(numbers);
  await models.User.updateMany(
    { mobileNumber: { $in: numbers } },
    { $set: { active: true, lastActive: null } }
  );
};
