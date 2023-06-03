const { remove, ref, child, get, set, onValue } = require('firebase/database');
const models = require('../../models');

module.exports.getResponse = async (id) => {
  const dbRef = ref(models.Response);
  let x;
  await get(child(dbRef, `response/${id}`))
    .then((snapshot) => {
      if (snapshot.exists()) {
        x = snapshot.val();
      } else {
        console.log('No data available');
      }
    })
    .catch((error) => {
      console.error(error);
    });
  return x;
};

module.exports.setResponse = async (pd, requestId, accept, distance) => {
  let numbers = [];
  for (const x of pd) {
    x.distance = distance;
    x.accept = accept;
    numbers.push(x.mobileNumber);
    set(
      ref(models.Response, 'response/' + `${requestId}/` + `${x.mobileNumber}`),
      x
    );
  }
  return numbers;
};
// module.exports.updateRes = async (requestId, number, distance, location) => {
//   set(
//     ref(
//       models.Response,
//       'response/' + `${requestId}/` + `${number}/` + `distance`
//     ),
//     distance
//   );
//   set(
//     ref(
//       models.Response,
//       'response/' + `${requestId}/` + `${number}/` + `accept`
//     ),
//     true
//   );
//   set(
//     ref(
//       models.Response,
//       'response/' + `${requestId}/` + `${number}/` + `location`
//     ),
//     location
//   );
// };
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
module.exports.deleteResponse = async (requestId) => {
  remove(ref(models.Response, 'response/' + `${requestId}/`), null);
};
