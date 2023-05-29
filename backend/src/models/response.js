const { initializeApp } = require('firebase/app');
const { getDatabase } = require('firebase/database');
const { firebaseResponseConfig } = require('../config/firebase.config');
const app = initializeApp(firebaseResponseConfig);
const Response = getDatabase(app);
module.exports = Response;
