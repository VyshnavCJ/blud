import 'package:blud_frontend/screens/phonelogin.dart';
import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenSplash = bloodStorage.token;
String phoneSplash = bloodStorage.phoneNumber;
String requestSplash = bloodStorage.requestID;

class Splash extends StatelessWidget {
  const Splash({super.key});

  void initState() {
    box.put(
        'BloodStorage',
        BloodStorage(
            token: tokenSplash,
            phoneNumber: phoneSplash,
            requestID: requestSplash,
            loggedin: 'no'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2558,
                left: MediaQuery.of(context).size.width * 0.0746),
            height: MediaQuery.of(context).size.height * 0.2585,
            width: MediaQuery.of(context).size.width * 0.6026,
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
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.0746,
                top: MediaQuery.of(context).size.height * 0.6973),
            width: MediaQuery.of(context).size.width * 163 / 375,
            height: MediaQuery.of(context).size.height * 43 / 727,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 13 / 375),
                    child: const Text('Continue')),
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  height: MediaQuery.of(context).size.height * 37 / 727,
                  width: MediaQuery.of(context).size.width * 67 / 375,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffFF4040),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>const PhoneLogin()));
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Icon(Icons.arrow_forward_rounded),
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
