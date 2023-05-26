const mongoose = require('mongoose');
const validator = require('validator');
const bcrypt = require('bcryptjs');

// sample use-case
const UserSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: [true, 'Please provide name'],
      minlength: 3,
      trim: true
    },
    email: {
      type: String,
      required: [true, 'Please provide email'],
      unique: true,
      validate: {
        validator: validator.isEmail,
        message: 'please provide valid email'
      },
      trim: true
    },
    password: {
      type: String,
      required: [true, 'Please provide password'],
      minlength: 6,
      trim: true
    }
  },
  { timestamps: true }
);

UserSchema.pre('save', async function () {
  if (!this.isModified('password')) return;
  const salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
});

UserSchema.methods.comparePassword = async function (candidatePassword) {
  const isMatch = await bcrypt.compare(candidatePassword, this.password);
  return isMatch;
};

module.exports = mongoose.model('User', UserSchema);
