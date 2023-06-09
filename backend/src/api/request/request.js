const models = require('../../models');
const {
  getAcceptableBloodGroups,
  getDonatableBloodGroups
} = require('../../utils');
const { calculateDistance } = require('./request.helpers');
const mongoose = require('mongoose');
const { whatsapp } = require('./request.helpers');

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
      { _id: { $ne: request.userId } },
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
  let numbers = [];

  for (const x of pd) {
    x.distance = 0;
    x.accept = false;
    numbers.push(x.mobileNumber);
    await models.Response.writeData(`${requestId}/${x.mobileNumber}`, x);
  }
  return numbers;
};

module.exports.sendWhatsapp = async (request, numbers) => {
  let x = request.time;
  let hr = Math.trunc(x / 100);
  let min = x % 100;
  let time = '';

  if (hr > 12) time = hr - 12 + ':' + min + ' PM';
  else time = hr + ':' + min + ' AM';

  let id = '';
  let hashId = '';

  do {
    let digits = '0123456789';

    for (let i = 0; i < 4; i++) {
      id += digits[Math.floor(Math.random() * 10)];
    }

    hashId = await models.Hash.findOne({ id: id });
  } while (hashId);

  await models.Hash.create({ id: id, requestId: request._id });

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
Case : ${request.case}\n
Enter ${id} to donate or (N/n)`;

  for (const number of numbers) {
    await whatsapp.messages
      .create({
        from: 'whatsapp:+14155238886',
        body: template,
        to: `whatsapp:+91${number}`
      })
      .then((message) => console.log(message.sid));
  }
};

module.exports.updateResponse = async (requestId, number) => {
  requestId = mongoose.Types.ObjectId(requestId);
  console.log(requestId);
  const requestLoc = await models.Request.findById(requestId).select(
    'location'
  );

  console.log(requestLoc);
  const accepter = await models.User.findOne({
    mobileNumber: number
  }).select('name location mobileNumber bloodGroup');

  const distance = calculateDistance(
    requestLoc.location.coordinates[1],
    requestLoc.location.coordinates[0],
    accepter.location.coordinates[1],
    accepter.location.coordinates[0]
  );

  accepter.active = false;

  await accepter.save();

  const doc = {
    name: accepter.name,
    location: accepter.location,
    mobileNumber: accepter.mobileNumber,
    bloodGroup: accepter.bloodGroup,
    distance: distance,
    accept: true
  };
  await models.Response.writeData(`${requestId}/${accepter.mobileNumber}`, doc);
};

module.exports.getRequest = async (mobileNumber) => {
  const response = await models.Response.readData('6480802cd9bd8c7741b33298');
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
        $and: [
          { isActiveRequest: true },
          { bloodGroup: { $in: bg } },
          { userId: { $ne: user._id } }
        ]
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
  await models.Response.deleteData(requestId);
};

module.exports.dropResponse = async (requestId) => {
  const response = await models.Response.readData(requestId);
  let numbers = [];

  for (const key in response) {
    if (response[key].accept == true) numbers.push(key);
  }

  await models.Response.deleteData(requestId);

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

module.exports.sheduledOperation = async () => {
  const requests = await models.Request.find({ isActiveRequest: true });

  for (let request of requests) {
    request.range = request.range + 1000;

    const bg = getAcceptableBloodGroups(request.bloodGroup);
    const lng = request.location.coordinates[0];
    const lat = request.location.coordinates[1];
    const maxdistance = request.range + 35000;
    const potentialDonors = await models.User.find({
      $and: [
        { active: true },
        { bloodGroup: { $in: bg } },
        { _id: { $ne: request.userId } },
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
    const response = await models.Response.readData(request._id);
    const oldNumbers = Object.keys(response);
    const filter_pd = potentialDonors.filter(
      (x) => !oldNumbers.includes(x.mobileNumber)
    );

    let numbers = [];

    for (const x of filter_pd) {
      x.distance = 0;
      x.accept = false;
      numbers.push(x.mobileNumber);
      await models.Response.writeDate(`${request._id}/${x.mobileNumber}`, x);
    }

    let x = request.time;
    let hr = Math.trunc(x / 100);
    let min = x % 100;
    let time = '';

    if (hr > 12) time = hr - 12 + ':' + min + ' PM';
    else time = hr + ':' + min + ' AM';

    let id = '';
    let hashId = '';

    do {
      let digits = '0123456789';

      for (let i = 0; i < 4; i++) {
        id += digits[Math.floor(Math.random() * 10)];
      }

      hashId = await models.Hash.findOne({ id: id });
    } while (hashId);

    await models.Hash.create({ id: id, requestId: request._id });

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
Case : ${request.case}\n
Enter ${id} to donate or (N/n)`;

    for (const number of numbers) {
      await whatsapp.messages
        .create({
          from: 'whatsapp:+14155238886',
          body: template,
          to: `whatsapp:+91${number}`
        })
        .then((message) => console.log(message.sid));
    }

    await request.save();
  }

  const users = await models.User.find({ active: false });
  for (let user of users) {
    const donatedDate = user.lastActive;
    const currentDate = new Date();
    let months = (currentDate.getFullYear() - donatedDate.getFullYear()) * 12;
    months -= donatedDate.getMonth() + 1;
    months += currentDate.getMonth();
    if (months > 3) {
      user.active = false;
      user.lastActive = null;
      user.save();
    }
  }
};
