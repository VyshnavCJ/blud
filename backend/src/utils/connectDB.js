const mongoose = require('mongoose').set('strictQuery', false);

const connectDB = async () => {
  mongoose
    .connect(process.env.MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    })
    .then(() => {
      console.log('MongoDB Connected...');
    })
    .catch((err) => {
      console.log(err);
    });
};

module.exports = connectDB;
