const fast2sms = require('fast-two-sms');

exports.generateOtp = (otp_length) => {
  var digits = '0123456789';
  let otp = '';
  for (let i = 0; i < otp_length; i++) {
    otp += digits[Math.floor(Math.random() * 10)];
  }
  return otp;
};

exports.fast2sms = async (message, contactNumber) => {
  try {
    if (process.env.NODE_ENV === 'production') {
      const res = await fast2sms.sendMessage({
        authorization: process.env.FAST2SMS,
        message,
        numbers: [contactNumber]
      });
    }
  } catch (error) {
    next(error);
  }
};
