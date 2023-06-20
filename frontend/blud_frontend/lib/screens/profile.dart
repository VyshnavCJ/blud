import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blud_frontend/screens/userreg.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenProf = bloodStorage.token;
String phoneProf = bloodStorage.phoneNumber;
String requestProf = bloodStorage.requestID;

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
        dob = response.data['user']['dob'];
        loaded = true;
      });
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
                left: MediaQuery.of(context).size.width - 130),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 98, left: 27),
            child: const Text('Profile',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 165, left: 100),
            child: Text(name,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 235, left: 25),
            child: const Text('Personal Details',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF802120))),
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserReg()));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 235, left: 300),
                child: const Text(
                  'EDIT',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF802120),
                      decoration: TextDecoration.underline),
                ),
              )),
          const Positioned(
              top: 145,
              left: 20,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFFFABAB),
                child: Icon(
                  Icons.person,
                  size: 35,
                  color: Color(0xFF802120),
                ),
              )),
          Container(
            margin: const EdgeInsets.only(top: 265, left: 23),
            width: 310,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF000000), width: 1.0)),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: loaded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          number,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          address,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          district,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          state,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          pinCode,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          gender,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Blood Group $bloodGroup',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          dob,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF949292)),
                        ),
                      ],
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF802120),
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
