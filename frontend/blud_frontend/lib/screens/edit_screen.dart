import 'package:blud_frontend/main.dart';
import 'package:blud_frontend/screens/navigation.dart';
import 'package:blud_frontend/widgets/date_selector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Hive_storage/blood_storage.dart';
import 'errorscreen.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenEdit = bloodStorage.token;
String phoneEdit = bloodStorage.phoneNumber;
String requestEdit = bloodStorage.requestID;
late Response response;
final dio = Dio();
editUser(address, pincode, district, state, dob, context) async {
  try {
    response =
        await dio.patch('https://blud-backend.onrender.com/api/v1/user/profile',
            data: {
              "address": address,
              "pinCode": pincode,
              "district": district,
              "state": state,
              "dob": dob,
            },
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $tokenEdit",
            }));
    if (response.data["success"]) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NavigationPanel(),
          ));
    } else {}
  } catch (e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout) {
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg = e.response?.data['msg'].toString().toString() ?? '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ErrorScreen(
            statusCode: statusCode,
            statusmsg: statusmsg,
            screen: 0,
          );
        }));
      } else if (e.type == DioExceptionType.sendTimeout) {
      } else if (e.type == DioExceptionType.receiveTimeout) {
      } else if (e.type == DioExceptionType.badResponse) {
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg = e.response?.data['msg'].toString() ?? '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ErrorScreen(
            statusCode: statusCode,
            statusmsg: statusmsg,
            screen: 0,
          );
        }));
      } else if (e.type == DioExceptionType.cancel) {
      } else {}
    } else {}
  }
}

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController districtcontroller = TextEditingController();
  final TextEditingController statecontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
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
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 40, left: 23),
              width: 38,
              height: 49,
              child: Image.asset('assets/images/blud_icon.png')),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 297),
            height: 43,
            width: 45,
            child: Image.asset('assets/images/blud_logo.png'),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 245,
                left: MediaQuery.of(context).size.width - 170),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 100 / 727,
                left: MediaQuery.of(context).size.width * 30 / 375),
            width: MediaQuery.of(context).size.width * 315 / 375,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(top: 40, left: 18),
                      width: MediaQuery.of(context).size.width * 60 / 375,
                      height: MediaQuery.of(context).size.height * 37 / 727,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFFF4040)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Icon(Icons.arrow_back_rounded),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 25),
                        child: Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:
                                MediaQuery.of(context).size.height * 20 / 727,
                            fontWeight: FontWeight.w800,
                          ),
                        )),
                  ],
                ),

                // const Positioned(
                //   top: 160, left: 135,
                //   child: CircleAvatar(radius: 45,
                //   backgroundColor: Color(0xFFFFABAB),)

                // ),
                SingleChildScrollView(
                    // margin: const EdgeInsets.only(top: 190),
                    child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const SizedBox(height: 12.0),
                    DateofBirthTextField(
                      textEditingController: dobcontroller,
                      displaytext: 'Date Of Birth',
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: addresscontroller,
                      decoration: InputDecoration(
                          labelText: 'Address',
                          filled: true,
                          fillColor: const Color(0xFFFFE3E3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: districtcontroller,
                      decoration: InputDecoration(
                          labelText: 'District',
                          filled: true,
                          fillColor: const Color(0xFFFFE3E3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: statecontroller,
                      decoration: InputDecoration(
                          labelText: 'State',
                          filled: true,
                          fillColor: const Color(0xFFFFE3E3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: pincodecontroller,
                      decoration: InputDecoration(
                          labelText: 'Pincode',
                          filled: true,
                          fillColor: const Color(0xFFFFE3E3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 150 / 375,
                        height: MediaQuery.of(context).size.height * 50 / 727,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                pressed = true;
                              });
                              address = addresscontroller.text.toString();
                              pincode = int.parse(pincodecontroller.text);
                              district = districtcontroller.text.toString();
                              state = statecontroller.text.toString();
                              dob = dobcontroller.text.toString();
                              gender = genderDD.toLowerCase();
                              bg = bloodgroupDD;
                              editUser(address, pincode, district, state, dob,
                                  context);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFFFF4040))),
                            child: pressed
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Edit Profile')))
                  ],
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
