const { StatusCodes } = require('http-status-codes');

const services = require('./user');

module.exports.login = async (req, res) => {
  const mobileNumber = req.body.mobileNumber;
  const token = await services.otpToken(mobileNumber);
  return res.status(StatusCodes.CREATED).json({
    success: true,
    msg: 'OTP send',
    token: token
  });
};

module.exports.auth = async (req, res) => {
  const validOtp = req.user.otp;
  const incomingOtp = req.body.otp;
  const mobileNumber = req.user.mobileNumber;
  const token = await services.otpVerify(validOtp, incomingOtp, mobileNumber);
  const isRegistered = await services.isRegistered(mobileNumber);
  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'OTP Verfied',
    token: token,
    isRegistered: isRegistered
  });
};

module.exports.create = async (req, res) => {
  req.body.mobileNumber = req.user.mobileNumber;
  const token = await services.createUser(req.body);
  return res.status(StatusCodes.CREATED).json({
    success: true,
    msg: 'User created',
    token: token
  });
};

module.exports.view = async (req, res) => {
  const user = await services.userDetails(req.user.mobileNumber);

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'User profile',
    user: user
  });
};
module.exports.edit = async (req, res) => {
  const user = await services.userEdit(req.user.mobileNumber, req.body);

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'User updated',
    user: user
  });
};

module.exports.home = async (req, res) => {
  const isActive = await services.checkRequest(req.user.mobileNumber);
  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Home data',
    isActiveRequest: isActive
  });
};
module.exports.history = async (req, res) => {
  const option = req.params.id;
  const mobileNumber = req.user.mobileNumber;
  let data = [];
  if (option == 1) {
    data = await services.getRequestHistory(mobileNumber);
  } else if (option == 2) {
    data = await services.getDonationHistory(mobileNumber);
  }

  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Home data',
    data: data
  });
};
