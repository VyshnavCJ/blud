const mongoose = require('mongoose');

const HashSchema = new mongoose.Schema({
  id: {
    type: Number,
    required: true
  },
  requestId: {
    type: mongoose.Types.ObjectId,
    required: true
  }
});

module.exports = mongoose.model('Hash', HashSchema);
