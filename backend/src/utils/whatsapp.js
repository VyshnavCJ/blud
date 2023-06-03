const { whatsappConfig } = require('../config');
const WhatsappCloudAPI = require('whatsappcloudapi_wrapper');
const Whatsapp = new WhatsappCloudAPI({
  accessToken: whatsappConfig.Meta_WA_accessToken,
  senderPhoneNumberId: whatsappConfig.Meta_WA_SenderPhoneNumberId,
  WABA_ID: whatsappConfig.Meta_WA_wabaId,
  graphAPIVersion: 'v13.0'
});

module.exports = Whatsapp;
