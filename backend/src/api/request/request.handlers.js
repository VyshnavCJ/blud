const { StatusCodes } = require('http-status-codes');
const cron = require('node-cron');
const services = require('./request');
const { whatsapp } = require('./request.helpers');
const models = require('../../models');

module.exports.create = async (req, res) => {
  const request = await services.createRequest(req.body, req.user.mobileNumber);
  const potentialDonors = await services.findDonors(request);
  const numbers = await services.createResponse(potentialDonors, request._id);

  await services.sendWhatsapp(request, numbers);

  return res.status(StatusCodes.CREATED).json({
    success: true,
    msg: 'Request Created',
    requestId: request._id
  });
};

module.exports.view = async (req, res) => {
  const requestDetails = await services.getRequest(req.user.mobileNumber);

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Details',
    requestDetails: requestDetails
  });
};

module.exports.accept = async (req, res) => {
  const mobileNumber = req.user.mobileNumber;

  await services.updateResponse(req.body.id, mobileNumber);

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Accepted'
  });
};

module.exports.complete = async (req, res) => {
  const requestId = req.body.id;
  const donorNumber = req.body.mobileNumber;

  const numbers = await services.updateRequest(requestId, donorNumber);

  for (const number of numbers) {
    await whatsapp.messages
      .create({
        from: 'whatsapp:+14155238886',
        body: `Sorry, the recipient choose another person.\n Not to worry, you can donate when new request comes`,
        to: `whatsapp:+91${number}`
      })
      .then((message) => console.log(message.sid));
  }

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Completed'
  });
};

module.exports.cancel = async (req, res) => {
  const numbers = await services.dropResponse(req.body.id);

  await services.dropRequest(req.body.id);
  await services.updateUser(numbers);

  for (const number of numbers) {
    await whatsapp.messages
      .create({
        from: 'whatsapp:+14155238886',
        body: `Sorry, the blood request is cancelled.\n Not to worry, You can donate when new request comes`,
        to: `whatsapp:+91${number}`
      })
      .then((message) => console.log(message.sid));
  }

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Cancelled'
  });
};

module.exports.whatsappRecieve = async (req, res) => {
  let recipientPhone = req.body.WaId;
  recipientPhone = Number(recipientPhone.replace('91', ''));

  let id = req.body.Body;
  if (id !== 'N' && id !== 'n') {
    id = Number(id);

    const hash = await models.Hash.findOne({ id: id })
      .select('requestId -_id')
      .lean();
    await services.updateResponse(hash.requestId, recipientPhone);

    await whatsapp.messages
      .create({
        from: 'whatsapp:+14155238886',
        body: `Thank you, you will be contacted by the Recipient if they choose you`,
        to: `whatsapp:+91${recipientPhone}`
      })
      .then((message) => console.log(message.sid));
  } else {
    await whatsapp.messages
      .create({
        from: 'whatsapp:+14155238886',
        body: `Its Ok you can do it another time`,
        to: `whatsapp:+91${recipientPhone}`
      })
      .then((message) => console.log(message.sid));
  }
};

cron.schedule('0 * * * *', services.sheduledOperation, {
  scheduled: true,
  timezone: 'Asia/Kolkata'
});
