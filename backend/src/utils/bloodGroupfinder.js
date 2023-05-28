module.exports.getDonatableBloodGroups = (bloodGroup) => {
  var donatableBloodGroups = [];

  switch (bloodGroup) {
    case 'A+':
      donatableBloodGroups = ['A+', 'AB+'];
      break;
    case 'A-':
      donatableBloodGroups = ['A+', 'A-', 'AB+', 'AB-'];
      break;
    case 'B+':
      donatableBloodGroups = ['B+', 'AB+'];
      break;
    case 'B-':
      donatableBloodGroups = ['B+', 'B-', 'AB+', 'AB-'];
      break;
    case 'AB+':
      donatableBloodGroups = ['AB+'];
      break;
    case 'AB-':
      donatableBloodGroups = ['AB+', 'AB-'];
      break;
    case 'O+':
      donatableBloodGroups = ['A+', 'B+', 'AB+', 'O+'];
      break;
    case 'O-':
      donatableBloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
      break;
    default:
      donatableBloodGroups = [];
      break;
  }

  return donatableBloodGroups;
};

module.exports.getAcceptableBloodGroups = (bloodGroup) => {
  var acceptableBloodGroups = [];

  switch (bloodGroup) {
    case 'A+':
      acceptableBloodGroups = ['A+', 'A-', 'O+', 'O-'];
      break;
    case 'A-':
      acceptableBloodGroups = ['A-', 'O-'];
      break;
    case 'B+':
      acceptableBloodGroups = ['B+', 'B-', 'O+', 'O-'];
      break;
    case 'B-':
      acceptableBloodGroups = ['B-', 'O-'];
      break;
    case 'AB+':
      acceptableBloodGroups = [
        'A+',
        'A-',
        'B+',
        'B-',
        'AB+',
        'AB-',
        'O+',
        'O-'
      ];
      break;
    case 'AB-':
      acceptableBloodGroups = ['A-', 'B-', 'AB-', 'O-'];
      break;
    case 'O+':
      acceptableBloodGroups = ['O+', 'O-'];
      break;
    case 'O-':
      acceptableBloodGroups = ['O-'];
      break;
    default:
      acceptableBloodGroups = [];
      break;
  }

  return acceptableBloodGroups;
};
