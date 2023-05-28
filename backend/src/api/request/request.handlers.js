const { StatusCodes } = require('http-status-codes');
const services = require('./request');

module.exports.create = async (req, res) => {
  const request_id = await services.createRequest(
    req.body,
    req.user.mobileNumber
  );
  const potentialDonors = await services.findDonors(request_id);
  const filteredPD = await services.filterDonors(potentialDonors, request_id);
  const response_id = await services.createResponse(filteredPD, request_id);
  await services.sendMessage(filteredPD, response_id);
  return res.status(StatusCodes.OK).json({
    success: true,
    msg: 'Request Created',
    request_id: request_id
  });
};
