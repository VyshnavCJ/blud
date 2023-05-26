/**
 * Represents an API error that can be handled.
 * @param {string} message - corresponding error message.
 * @param {number} statusCode - corresponding http status code.
 */
class APIError extends Error {
  constructor(message, statusCode) {
    super(message);
    this.statusCode = statusCode;
    this.success = false;
  }
}

/** Generates a custom api error with given message and status code. */
const generateAPIError = (msg, statusCode) => {
  return new APIError(msg, statusCode);
};

module.exports = { generateAPIError, APIError };
