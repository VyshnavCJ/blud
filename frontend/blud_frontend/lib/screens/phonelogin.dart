import 'package:blud_frontend/Hive_storage/blood_storage.dart';
import 'package:blud_frontend/main.dart';
import 'package:blud_frontend/screens/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();
Future getHTTP(num phoneNumber, context) async {
  Response response = await dio.post(
      'https://blud-backend.onrender.com/api/v1/user/login',
      data: {"mobileNumber": phoneNumber});
  if (response.data['success']) {
    box.put(
        'BloodStorage',
        BloodStorage(
            token: response.data["token"].toString(),
            phoneNumber: phoneNumber.toString(),
            requestID: "",
            loggedin: 'yes'));
    // BloodStorage bloodStorage = box.get("BloodStorage");
    // print("HEHE: ${bloodStorage.phoneNumber}");
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => const OTPScreen()))
        .then((_) => const PhoneLogin());
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
                top: MediaQuery.of(context).size.height * 0.4973, left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your phone\nnumber',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'You will receive a 4 digit code for\nphone number verification',
                  style: TextStyle(fontFamily: "Lora", fontSize: 13),
                ),
                SizedBox(
                  width: 203,
                  height: 40,
                  child: TextField(
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
                left: 28, top: MediaQuery.of(context).size.height * 0.6973),
            width: 163,
            height: 43,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pressed
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(left: 13),
                        child: const Text('Continue')),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.only(right: 3),
                  height: 37,
                  width: pressed ? 155 : 67,
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
                            margin: const EdgeInsets.fromLTRB(65, 5, 65, 5),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
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
