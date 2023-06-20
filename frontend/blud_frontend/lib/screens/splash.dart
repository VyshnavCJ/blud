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

  void initState(){
    box.put(
        'BloodStorage',
        BloodStorage(
          token: tokenSplash,
          phoneNumber: phoneSplash,
          requestID: requestSplash,
          loggedin: false
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(top: 56, left: 25),
              width: 55,
              height: 70,
              child: Image.asset('assets/images/blud_icon.png')),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 186, left: 28),
            height: 188,
            width: 226,
            child: Image.asset('assets/images/blud_logo.png'),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 245,
                left: MediaQuery.of(context).size.width - 170),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 28, top: 507),
            width: 163,
            height: 43,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 13),
                    child: const Text('Continue')),
                Container(
                  margin: const EdgeInsets.only(right: 3),
                  height: 37,
                  width: 67,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffFF4040),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneLogin()));
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
