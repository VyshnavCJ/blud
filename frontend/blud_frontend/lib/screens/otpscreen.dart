// ignore_for_file: avoid_print

import 'package:blud_frontend/screens/navigation.dart';
import 'package:blud_frontend/screens/userreg.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../Hive_storage/blood_storage.dart';
import '../main.dart';
import 'errorscreen.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenOTP = bloodStorage.token;
String phoneOTP = bloodStorage.phoneNumber;
String requestOTP = bloodStorage.requestID;

final dio = Dio();
otpVal(otpCode, context) async {
  try {
    Response response =
        await dio.post('https://blud-backend.onrender.com/api/v1/user/auth',
            data: {"otp": otpCode},
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $tokenOTP",
            }));
    print(response.data['msg']);
    if (response.data['success']) {
      box.put(
          'BloodStorage',
          BloodStorage(
              token: response.data["token"].toString(),
              phoneNumber: phoneOTP,
              requestID: requestOTP,
              loggedin: 'no'));
      BloodStorage bloodStorage = box.get("BloodStorage");
      print(bloodStorage.token);
      if (response.data['isRegistered']) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const NavigationPanel()),
          (route) => route
              .isCurrent, 
        );
        // Navigator.pushReplacement(context,
        //     MaterialPageRoute(builder: (context) => const NavigationPanel(),
        // ));
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const NavigationPanel()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const UserReg()));
      }
    }
  } catch (e) {
    if (e is DioException) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionTimeout) {
        print(e);
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
        // Handle send timeout error
        print(e);
      } else if (e.type == DioExceptionType.receiveTimeout) {
        // Handle receive timeout error
        print(e);
      } else if (e.type == DioExceptionType.badResponse) {
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg = e.response?.data['msg'] ?? '';
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ErrorScreen(
              statusCode: statusCode, statusmsg: statusmsg, screen: 0);
        }));
      } else if (e.type == DioExceptionType.cancel) {
        print(e);
      } else {
        print(e);
      }
    } else {
      // Handle other non-Dio exceptions
    }
  }
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int? otpCode;
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    pressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0962,
                  left: MediaQuery.of(context).size.width * 0.0666),
              width: MediaQuery.of(context).size.width * 0.1466,
              height: MediaQuery.of(context).size.height * 0.0962,
              child: Image.asset('assets/images/blud_icon.png')),
          Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.0962,
                  left: MediaQuery.of(context).size.width * 253 / 375),
              width: MediaQuery.of(context).size.width * 0.2466,
              height: MediaQuery.of(context).size.height * 0.1962,
              child: Image.asset('assets/images/blud_logo.png')),
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
                top: MediaQuery.of(context).size.height * 217 / 727,
                left: MediaQuery.of(context).size.width * 32 / 375),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the verification\ncode',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 26 / 727,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'You will receive a 6 digit code for phone\nnumber verification',
                  style: TextStyle(
                      fontFamily: "Lora",
                      fontSize: MediaQuery.of(context).size.height * 13 / 727),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.start,
                    numberOfFields: 6,
                    showFieldAsBox: true,
                    borderColor: const Color(0xffFF4040),
                    borderRadius: BorderRadius.circular(30),
                    fillColor: const Color(0xffFFE3E3),
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otpCode = int.parse(verificationCode);
                      });
                    },
                    focusedBorderColor: const Color(0xffFF4040),
                    obscureText: true,
                    showCursor: false,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 13 / 727),
                  width: MediaQuery.of(context).size.width * 163 / 375,
                  height: MediaQuery.of(context).size.height * 43 / 727,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pressed
                          ? Container()
                          : Container(
                              margin: const EdgeInsets.only(left: 13),
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            13 /
                                            727),
                              )),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(right: 3),
                        height: MediaQuery.of(context).size.height * 37 / 727,
                        width: pressed
                            ? MediaQuery.of(context).size.width * 155 / 375
                            : MediaQuery.of(context).size.width * 67 / 375,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xffFF4040),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pressed = true;
                            });
                            otpVal(otpCode, context);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: pressed
                              ? Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(65, 5, 65, 5),
                                  child: const Center(
                                    child: FittedBox(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const Icon(Icons.arrow_forward_rounded),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
