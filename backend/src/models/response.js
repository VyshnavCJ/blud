const { initializeApp } = require('firebase/app');
const { getDatabase } = require('firebase/database');
const { firebaseConfig } = require('../config/firebase.config');
const { remove, ref, child, get, set } = require('firebase/database');

class FirebaseRealtimeDatabase {
  constructor(rootPath) {
    const app = initializeApp(firebaseConfig);
    this.db = getDatabase(app);
    this.rootPath = rootPath;
  }

  async writeData(path, data) {
    await set(ref(this.db, `${this.rootPath}/${path}`), data);
    console.log('Data written successfully!');
    return true;
  }

  async readData(path) {
    const dbref = ref(this.db);
    const snapshot = await get(child(dbref, `${this.rootPath}/${path}`));
    const data = snapshot.val();
    return data;
  }

  async deleteData(path) {
    await remove(ref(this.db, `${this.rootPath}/${path}/`), null);
    console.log('Data deleted successfully!');
    return true;
  }
}

const Response = new FirebaseRealtimeDatabase('response');
module.exports = { Response };
