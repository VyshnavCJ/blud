const { Whatsapp } = require('../../utils');
const { StatusCodes } = require('http-status-codes');
const cron = require('node-cron');
const services = require('./request');
const { whatsappConfig } = require('../../config');

module.exports.create = async (req, res) => {
  const request = await services.createRequest(req.body, req.user.mobileNumber);
  const potentialDonors = await services.findDonors(request);
  const numbers = await services.createResponse(potentialDonors, request._id);

  // await services.sendWhatsapp(request, numbers);

  return res.status(StatusCodes.CREATED).json({
    success: true,
    msg: 'Request Created',
    requestid: request._id
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

  await services.updateRequest(requestId, donorNumber);

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Completed'
  });
};

module.exports.cancel = async (req, res) => {
  const numbers = await services.dropResponse(req.body.id);

  await services.dropRequest(req.body.id);
  await services.updateUser(numbers);
  // await Whatsapp.sendText({
  //   recipientPhone: 917306255230,
  //   message: `Sry the the blood request is cancelled.\n Not to worry You can donote when new request comes`
  // });

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Cancelled'
  });
};

module.exports.whatsappVerify = (req, res) => {
  try {
    console.log('GET: Someone is pinging me!');

    let mode = req.query['hub.mode'];
    let token = req.query['hub.verify_token'];
    let challenge = req.query['hub.challenge'];
    if (
      mode &&
      token &&
      mode === 'subscribe' &&
      whatsappConfig.Meta_WA_VerifyToken === token
    ) {
      return res.status(200).send(challenge);
    } else {
      return res.sendStatus(403);
    }
  } catch (error) {
    console.error({ error });
    return res.sendStatus(500);
  }
};

module.exports.whatsappRecieve = async (req, res) => {
  try {
    let data = Whatsapp.parseMessage(req.body);

    if (data?.isMessage) {
      let incomingMessage = data.message;
      let recipientPhone = incomingMessage.from.phone; // extract the phone number of sender
      let recipientName = incomingMessage.from.name;
      let typeOfMsg = incomingMessage.type; // extract the type of message (some are text, others are images, others are responses to buttons etc...)
      let message_id = incomingMessage.message_id; // extract the message id
      if (typeOfMsg === 'simple_button_message') {
        let button_id = incomingMessage.button_reply.id;

        if (button_id !== 'null') {
          await services.pdateResponse(button_id, recipientPhone);
          await Whatsapp.sendText({
            recipientPhone: recipientPhone,
            message: `Not to brag, but unlike humans, chatbots are super fast⚡, we never sleep, never rest, never take lunch🍽 and can multitask.\n\nAnway don't fret, a hoooooman will 📞contact you soon.\n\nWanna blast☎ his/her phone😈?\nHere are the contact details:`
          });
        } else
          await Whatsapp.sendText({
            recipientPhone: recipientPhone,
            message: `It's ok try to donate next time`
          });
      }
    }
    return res.sendStatus(200);
  } catch (error) {
    console.error({ error });
    return res.sendStatus(500);
  }
};

cron.schedule('0 * * * *', services.sheduledOperation, {
  scheduled: true,
  timezone: 'Asia/Kolkata'
});
