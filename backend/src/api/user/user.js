const { StatusCodes } = require('http-status-codes');
const models = require('../../models');
const { generateJwt } = require('../../utils');
const { generateOtp, fast2sms } = require('./user.helpers');
const { generateAPIError } = require('../../errors');

module.exports.otpToken = async (mobileNumber) => {
  const otp = generateOtp(6);
  console.log(otp);
  const token = generateJwt(
    { otp: otp, mobileNumber: mobileNumber },
    process.env.JWT_OTP_LIFETIME
  );
  fast2sms(otp, mobileNumber);
  return token;
};

module.exports.isRegistered = async (mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber });
  return user ? true : false;
};

module.exports.createUser = async (user) => {
  const isUserExists = await models.User.findOne({
    mobileNumber: user.mobileNumber
  });
  if (isUserExists)
    throw generateAPIError('User already exists', StatusCodes.BAD_REQUEST);
  await models.User.create(user);

  const token = generateJwt(
    { mobileNumber: user.mobileNumber },
    process.env.JWT_LIFETIME
  );
  return token;
};

module.exports.otpVerify = async (validOtp, incomingOtp, mobileNumber) => {
  if (validOtp != incomingOtp) {
    throw generateAPIError('Invalid otp', 402);
  }

  const token = generateJwt(
    { mobileNumber: mobileNumber },
    process.env.JWT_LIFETIME
  );
  return token;
};

module.exports.userDetails = async (mobileNumber) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber }).select(
    '-location -active -createdAt -updatedAt -__v'
  );
  return user;
};

module.exports.userEdit = async (mobileNumber, newDetails) => {
  const user = await models.User.findOne({ mobileNumber: mobileNumber }).select(
    '-location -active -createdAt -updatedAt -__v'
  );
  if (newDetails.address) {
    user.address = newDetails.address;
  }
  if (newDetails.pinCode) {
    user.pinCode = newDetails.pinCode;
  }

  if (newDetails.district) {
    user.district = newDetails.district;
  }
  if (newDetails.state) {
    user.state = newDetails.state;
  }
  if (newDetails.dob) {
    user.dob = newDetails.dob;
  }
  if (newDetails.gender) {
    user.gender = newDetails.gender;
  }
  await user.save();
  return user;
};
