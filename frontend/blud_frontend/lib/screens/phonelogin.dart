import 'package:blud_frontend/screens/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:blud_frontend/screens/userreg.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 56, left: 25),
              width: 55,
              height: 70,
              child: Image.asset('assets/images/blud_icon.png')),
          Container(
            margin: const EdgeInsets.only(top: 52, left: 223),
            height: 113,
            width: 132,
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
            margin: const EdgeInsets.only(top: 317, left: 32),
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
                  child: TextFormField(
                    initialValue: "+91",
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
            margin: const EdgeInsets.only(left: 28, top: 557),
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
                              builder: (context) => const OTPScreen()));
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
