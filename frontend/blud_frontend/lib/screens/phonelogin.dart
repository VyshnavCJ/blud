// ignore_for_file: avoid_print

import 'package:blud_frontend/Hive_storage/blood_storage.dart';
import 'package:blud_frontend/main.dart';
import 'package:blud_frontend/screens/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'errorscreen.dart';

final dio = Dio();
Future getHTTP(num phoneNumber, context) async {
  try {
    print('123');
    Response response = await dio.post(
        'https://blud-backend.onrender.com/api/v1/user/login',
        data: {"mobileNumber": phoneNumber});
    print('23');
    if (response.data['success']) {
      box.put(
          'BloodStorage',
          BloodStorage(
              token: response.data["token"].toString(),
              phoneNumber: phoneNumber.toString(),
              requestID: "",
              loggedin: 'no'));
      print('Phone Login-->${response.data["token"]}');
      print('Box Token-->${bloodStorage.token}');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const OTPScreen()));
    }
  } catch (e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout) {
        print('connectontimeout$e');
        int statusCode = e.response?.statusCode ?? 0;
        String statusmsg;
        if (statusCode >= 500) {
          statusmsg = e.response?.data['msg'] ?? '';
        } else {
          statusmsg = '';
        }
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

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  bool pressed = false;

  final TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    pressed = false;
    box.put(
        'BloodStorage',
        BloodStorage(
            token: '', phoneNumber: '', requestID: "", loggedin: 'no'));
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
                top: MediaQuery.of(context).size.height * 0.3573,
                left: MediaQuery.of(context).size.width * 25 / 375),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your phone\nnumber',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 26 / 727,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'You will receive a 6 digit code for\nphone number verification',
                  style: TextStyle(
                      fontFamily: "Lora",
                      fontSize: MediaQuery.of(context).size.height * 13 / 727),
                ),
                SizedBox(
                  width: 150,
                  height: MediaQuery.of(context).size.height * 40 / 727,
                  child: TextField(
                    cursorColor: const Color(0xffFF4040),
                    controller: phoneNoController,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffFFABAB), width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFFABAB)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0746,
                top: MediaQuery.of(context).size.height * 0.5973),
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
                              fontSize: MediaQuery.of(context).size.height *
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
                      getHTTP(int.parse(phoneNoController.text), context);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: pressed
                        ? Container(
                            margin: const EdgeInsets.fromLTRB(67, 7, 67, 7),
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
    );
  }
}
