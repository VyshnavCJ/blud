const mongoose = require('mongoose');
const geocoder = require('../utils/geocoder');

const UserSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Please provide name'],
      minlength: 3,
      maxlength: 50
    },
    mobileNumber: {
      type: String,
      required: [true, 'Please provide Phone number'],
      unique: true,
      minlength: 10,
      maxlength: 13
    },
    address: {
      type: String,
      required: [true, 'Plz provide address']
    },
    district: {
      type: String,
      required: [true, 'Plz provide district']
    },
    state: {
      type: String,
      required: [true, 'Plz provide state']
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
    gender: {
      type: String,
      required: true,
      enum: ['male', 'female', 'others']
    },
    bloodGroup: {
      type: String,
      required: true,
      enum: ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-']
    },
    dob: {
      type: Date,
      required: true
    },
    active: {
      type: Boolean,
      default: true
    },
    lastActive: {
      type: Date,
      default: null
    }
  },
  { timestamps: true }
);

UserSchema.index({ location: '2dsphere' });
UserSchema.pre('save', async function (next) {
  if (!this.isModified('pinCode')) return;
  const loc = await geocoder.geocode(this.pinCode);

  this.location = {
    type: 'Point',
    coordinates: [loc[0].longitude, loc[0].latitude]
  };
  next();
});

module.exports = mongoose.model('User', UserSchema);
