const { initializeApp } = require('firebase/app');
const { getDatabase } = require('firebase/database');
const { firebaseConfig } = require('../config/firebase.config');
const app = initializeApp(firebaseConfig);
const Response = getDatabase(app);
module.exports = Response;
