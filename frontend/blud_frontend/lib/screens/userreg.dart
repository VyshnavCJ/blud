import 'package:blud_frontend/main.dart';
import 'package:blud_frontend/screens/navigation.dart';
import 'package:blud_frontend/widgets/date_selector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Hive_storage/blood_storage.dart';
import 'errorscreen.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenREG = bloodStorage.token;
String phoneREG = bloodStorage.phoneNumber;
String requestREG = bloodStorage.requestID;
late Response response;
final dio = Dio();
createUser(
    name, address, pincode, district, state, dob, gender, bg, context) async {
  try {
    response =
        await dio.post('https://blud-backend.onrender.com/api/v1/user/create',
            data: {
              "name": name,
              "address": address,
              "pinCode": pincode,
              "district": district,
              "state": state,
              "dob": dob,
              "gender": gender,
              "bloodGroup": bg
            },
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $tokenREG",
            }));
    if (response.data["success"]) {
      box.put(
          'BloodStorage',
          BloodStorage(
              token: response.data["token"].toString(),
              phoneNumber: phoneREG,
              requestID: requestREG,
              loggedin: 'no'));
      _showMyDialog(context);
    } else {}
    print(response);
  } catch (e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout) {
        print('connectontimeout$e');
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg = e.response?.data['msg'] ?? '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ErrorScreen(
            statusCode: statusCode,
            statusmsg: statusmsg,
            screen: 0,
          );
        }));
      } else if (e.type == DioExceptionType.sendTimeout) {
        print('senttimeout$e');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('receivetimeout$e');
      } else if (e.type == DioExceptionType.badResponse) {
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg = e.response?.data['msg'] ?? '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ErrorScreen(
            statusCode: statusCode,
            statusmsg: statusmsg,
            screen: 0,
          );
        }));
      } else if (e.type == DioExceptionType.cancel) {
        print('cancle$e');
      } else {
        print('else$e');
      }
    } else {
      print("other$e");
    }
  }
}

Future<void> _showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Note'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'Connect with our WhatsApp to Continue\nTo connect send "join shoot-rocket" to the WhatsApp number that pops up when pressing join'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:
                const Text('Join', style: TextStyle(color: Color(0xFFFF4040))),
            onPressed: () {
              launch(
                  'https://api.whatsapp.com/send/?phone=14155238886&text=join+shoot-rocket&type=phone_number&app_absent=0');

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavigationPanel()),
                (route) => route.isCurrent,
              );
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class UserReg extends StatefulWidget {
  const UserReg({super.key});

  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController districtcontroller = TextEditingController();
  final TextEditingController statecontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  String? name;
  String? gender;
  String? bg;
  String? dob;
  String? address;
  String? district;
  String? state;
  int? pincode;
  bool pressed = false;

  String bloodgroupDD = 'Blood Group';
  String genderDD = 'Gender';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 40 / 727,
                  left: MediaQuery.of(context).size.width * 23 / 375),
              width: MediaQuery.of(context).size.width * 38 / 375,
              height: MediaQuery.of(context).size.height * 49 / 727,
              child: Image.asset('assets/images/blud_icon.png')),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 40 / 727,
                left: MediaQuery.of(context).size.width * 297 / 375),
            height: MediaQuery.of(context).size.height * 43 / 727,
            width: MediaQuery.of(context).size.width * 45 / 37,
            child: Image.asset('assets/images/blud_logo.png'),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 482 / 727,
                left: MediaQuery.of(context).size.width * 205 / 375),
            width: MediaQuery.of(context).size.width * 170 / 375,
            height: MediaQuery.of(context).size.height * 245 / 727,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 120 / 727,
                left: MediaQuery.of(context).size.width * 25 / 375),
            width: MediaQuery.of(context).size.width * 325 / 375,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'USER REGISTRATION',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: MediaQuery.of(context).size.height * 15 / 727,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF700606)),
                  ),
                ),
                // const Positioned(
                //   top: 160, left: 135,
                //   child: CircleAvatar(radius: 45,
                //   backgroundColor: Color(0xFFFFABAB),)

                // ),
                Container(
                    height: MediaQuery.of(context).size.height - 200,
                    // margin: const EdgeInsets.only(top: 190),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextField(
                            controller: namecontroller,
                            decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(color: Color(0xFF700606)),
                                filled: true,
                                fillColor: const Color(0xFFFFE3E3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606)))),
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 325 / 375,
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFFFE3E3)),
                            child: DropdownButton<String>(
                              value: genderDD,
                              hint: const Text('Select Gender'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  genderDD = newValue!;
                                });
                              },
                              underline: Container(),
                              items: <String>[
                                'Gender',
                                'Male',
                                'Female'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF700606))),
                                );
                              }).toList(),
                              alignment: Alignment.center,
                            ),
                          ),

                          // TextField(
                          //   controller: gendercontroller,
                          //   decoration: InputDecoration(
                          //       labelText: 'Gender',
                          //       filled: true,
                          //       fillColor: const Color(0xFFFFE3E3),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       )),
                          // ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 325 / 375,
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFFFFE3E3)),
                            child: DropdownButton<String>(
                              value: bloodgroupDD,
                              hint: Text('Select Blood Group'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  bloodgroupDD = newValue!;
                                });
                              },
                              underline: Container(),
                              items: <String>[
                                'Blood Group',
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF700606))),
                                );
                              }).toList(),
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          DateofBirthTextField(
                              textEditingController: dobcontroller,
                              displaytext: 'Date Of Birth'),
                          // TextField(
                          //   controller: dobcontroller,
                          //   decoration: InputDecoration(
                          //       labelText: 'DOB',
                          //       filled: true,
                          //       fillColor: const Color(0xFFFFE3E3),
                          //       border: OutlineInputBorder(
                          //         borderRadius: BorderRadius.circular(10.0),
                          //       )),
                          // ),
                          const SizedBox(height: 12.0),
                          TextField(
                            controller: addresscontroller,
                            decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Color(0xFF700606)),
                                filled: true,
                                fillColor: const Color(0xFFFFE3E3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606)))),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            controller: districtcontroller,
                            decoration: InputDecoration(
                                labelText: 'District',
                                labelStyle: TextStyle(color: Color(0xFF700606)),
                                filled: true,
                                fillColor: const Color(0xFFFFE3E3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606)))),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            controller: statecontroller,
                            decoration: InputDecoration(
                                labelText: 'State',
                                labelStyle: TextStyle(color: Color(0xFF700606)),
                                filled: true,
                                fillColor: const Color(0xFFFFE3E3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606)))),
                          ),
                          const SizedBox(height: 12.0),
                          TextField(
                            controller: pincodecontroller,
                            decoration: InputDecoration(
                                labelText: 'Pincode',
                                labelStyle: TextStyle(color: Color(0xFF700606)),
                                filled: true,
                                fillColor: const Color(0xFFFFE3E3),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606))),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide:
                                        BorderSide(color: Color(0xFF700606)))),
                          ),
                          const SizedBox(height: 15.0),
                          SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 150 / 375,
                              height:
                                  MediaQuery.of(context).size.height * 50 / 727,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      pressed = true;
                                    });
                                    name = namecontroller.text.toString();
                                    address = addresscontroller.text.toString();
                                    pincode = int.parse(pincodecontroller.text);
                                    district =
                                        districtcontroller.text.toString();
                                    state = statecontroller.text.toString();
                                    dob = dobcontroller.text.toString();
                                    gender = genderDD.toLowerCase();
                                    bg = bloodgroupDD;
                                    createUser(name, address, pincode, district,
                                        state, dob, gender, bg, context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xFFFF4040))),
                                  child: pressed
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'Create Profile',
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  15 /
                                                  727),
                                        )))
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
