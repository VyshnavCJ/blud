const { ref, child, get, set } = require('firebase/database');
const models = require('../../models');

module.exports.getResponse = async (id) => {
  const dbRef = ref(models.Response);
  await get(child(dbRef, `${id}`))
    .then((snapshot) => {
      if (snapshot.exists()) {
        return snapshot.val();
      } else {
        console.log('No data available');
      }
    })
    .catch((error) => {
      console.error(error);
    });
};

module.exports.setResponse = async (fpd, id) => {
  await set(ref(models.Response, 'response/' + id), fpd);
};

module.exports.calculateDistance = (lat1, lon1, lat2, lon2) => {
  const earthRadius = 6371; // Radius of the Earth in kilometers

  // Convert latitude and longitude from degrees to radians
  const radLat1 = toRadians(lat1);
  const radLon1 = toRadians(lon1);
  const radLat2 = toRadians(lat2);
  const radLon2 = toRadians(lon2);

  // Calculate the differences between the latitudes and longitudes
  const deltaLat = radLat2 - radLat1;
  const deltaLon = radLon2 - radLon1;

  // Use the Haversine formula to calculate the distance between the two locations
  const a =
    Math.sin(deltaLat / 2) ** 2 +
    Math.cos(radLat1) * Math.cos(radLat2) * Math.sin(deltaLon / 2) ** 2;
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

  // Calculate the distance in kilometers
  const distance = earthRadius * c;

  return distance;
};

function toRadians(degrees) {
  return degrees * (Math.PI / 180);
}
