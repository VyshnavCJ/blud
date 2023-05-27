const connectDB = require('./connectDB');
const { generateJwt, verifyJwt } = require('./jwt');
module.exports = {
  connectDB,
  generateJwt,
  verifyJwt
};
