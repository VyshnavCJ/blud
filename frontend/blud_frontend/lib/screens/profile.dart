// ignore_for_file: avoid_print

import 'package:blud_frontend/screens/edit_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';
import 'errorscreen.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenProf = bloodStorage.token;
String numberProf = bloodStorage.phoneNumber;
String requestProf = bloodStorage.requestID;
String loginProf = bloodStorage.loggedin;

class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String number = '';
  String address = '';
  String district = '';
  String state = '';
  String pinCode = '';
  String gender = '';
  String bloodGroup = '';
  String dob = '';
  bool loaded = false;

  final dio = Dio();

  profileRequest() async {
    try {
      Response response =
          await dio.get('https://blud-backend.onrender.com/api/v1/user/profile',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenProf",
              }));
      print(response);
      if (response.data['success']) {
        setState(() {
          name = response.data['user']['name'];
          number = response.data['user']['mobileNumber'];
          address = response.data['user']['address'];
          district = response.data['user']['district'];
          state = response.data['user']['state'];
          pinCode = response.data['user']['pinCode'];
          gender = response.data['user']['gender'];
          bloodGroup = response.data['user']['bloodGroup'];
          dob = response.data['user']['dob'].toString().substring(0, 10);
          loaded = true;
        });
      }
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
              screen: 1,
            );
          }));
        } else if (e.type == DioExceptionType.sendTimeout) {
          print('senttimeout$e');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('receivetimeout$e');
        } else if (e.type == DioExceptionType.badResponse) {
          print(e.response);
          int statusCode = e.response?.statusCode ?? 0;
          var statusmsg = e.response?.data['msg'] ?? '';

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ErrorScreen(
              statusCode: statusCode,
              statusmsg: statusmsg.toString(),
              screen: 1,
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

  @override
  void initState() {
    super.initState();
    profileRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: MediaQuery.of(context).size.height * 98 / 727,
                left: MediaQuery.of(context).size.width * 27 / 375),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 98, left: 27),
                  child: Text('Profile',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: MediaQuery.of(context).size.height * 20 / 727,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 35 / 375,
                        backgroundColor: Color(0xFFFFABAB),
                        child: Icon(
                          Icons.person,
                          size: MediaQuery.of(context).size.width * 35 / 375,
                          color: Color(0xFF802120),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 15 / 375),
                        child: Text(name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  MediaQuery.of(context).size.height * 21 / 727,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Personal Details',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize:
                                  MediaQuery.of(context).size.height * 15 / 727,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF802120))),
                      Container(
                        margin: EdgeInsets.only(
                            right:
                                MediaQuery.of(context).size.width * 60 / 375),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileEdit()));
                            },
                            child: Text(
                              'EDIT',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: MediaQuery.of(context).size.height *
                                      15 /
                                      727,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF802120),
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 310 / 375,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xFF000000), width: 1.0)),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: loaded
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                number,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                address,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                district,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                state,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                pinCode,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                gender,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                'Blood Group $bloodGroup',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                dob,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            14 /
                                            727,
                                    color: const Color(0xFF949292)),
                              ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF802120),
                            ),
                          ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width * 100 / 375,
                    height: MediaQuery.of(context).size.height * 40 / 727,
                    child: ElevatedButton(
                        onPressed: () {
                          box.put(
                              'BloodStorage',
                              BloodStorage(
                                  token: '',
                                  phoneNumber: '',
                                  requestID: '',
                                  loggedin: 'no'));
                          box.clear();
                          box.close();
                          box.deleteFromDisk();
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MainApp();
                          }));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFFF4040))),
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height *
                                  14 /
                                  727),
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
