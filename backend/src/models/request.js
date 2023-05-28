const mongoose = require('mongoose');
const geocoder = require('../utils/geocoder');
// sample use-case
const RequestSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Please provide name'],
      minlength: 3,
      maxlength: 50
    },
    bleedingPlace: {
      type: String
    },
    hospital: {
      type: String
    },
    pinCode: {
      type: String,
      required: [true, 'Plz provide pin-code'],
      minlength: 6,
      maxlength: 6
    },
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
    units: {
      type: Number,
      required: true
    },
    bystander: {
      type: String,
      required: true
    },
    case: {
      type: String,
      required: true
    },
    bloodGroup: {
      type: String,
      required: true,
      enum: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
    },
    date: {
      type: Date,
      required: true
    },
    time: {
      type: Number,
      required: true
    },
    userId: {
      type: mongoose.Types.ObjectId,
      ref: 'User',
      required: true
    },
    donorId: {
      type: mongoose.Types.ObjectId,
      ref: 'User'
    },
    isActiveRequest: {
      type: Boolean,
      default: true
    }
  },
  { timestamps: true }
);

RequestSchema.pre('save', async function (next) {
  if (!this.isModified('pinCode')) return;
  const loc = await geocoder.geocode(this.pinCode);

  this.location = {
    type: 'Point',
    coordinates: [loc[0].longitude, loc[0].latitude]
  };
  next();
});

module.exports = mongoose.model('Request', RequestSchema);
