const { StatusCodes } = require('http-status-codes');

module.exports.login = async (req, res) => {
  return res.status(StatusCodes.CREATED).json({
    success: true,
    msg: 'heloo'
  });
};
