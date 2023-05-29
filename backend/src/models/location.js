const mongoose = require('mongoose');
const LocationSchema = new mongoose.Schema(
  {
    location: {
      type: {
        type: String,
        enum: ['Point']
      },
      coordinates: {
        type: [Number],
        index: '2dsphere'
      }
    },
    mobileNumber: {
      type: Number,
      required: true
    }
  },
  { timeStamps: true }
);
module.exports = mongoose.model('Location', LocationSchema);
