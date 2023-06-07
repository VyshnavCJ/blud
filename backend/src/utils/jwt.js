const jwt = require('jsonwebtoken');

const generateJwt = (payload, expires) => {
  const token = jwt.sign(
    {
      payload
    },
    process.env.JWT_SECRET,
    { expiresIn: expires }
  );

  return token;
};

const verifyJwt = (token, next) => {
  try {
    const { userId } = jwt.verify(token, process.env.JWT_SECRET);
    return userId;
  } catch (err) {
    next(err);
  }
};

module.exports = { verifyJwt, generateJwt };
