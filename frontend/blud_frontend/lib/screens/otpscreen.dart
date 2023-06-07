import 'package:blud_frontend/screens/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otpCode = "";

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
                  'Enter the verification\ncode',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'You will receive a 4 digit code for phone\nnumber verification',
                  style: TextStyle(fontFamily: "Lora", fontSize: 13),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.start,
                    numberOfFields: 4,
                    showFieldAsBox: true,
                    borderColor: const Color(0xffFF4040),
                    borderRadius: BorderRadius.circular(30),
                    fillColor: const Color(0xffFFE3E3),
                    onSubmit: (String verificationCode) {
                      setState(() {
                        otpCode = verificationCode;
                      });
                    },
                    focusedBorderColor: const Color(0xffFF4040),
                    obscureText: true,
                    showCursor: false,
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
                      print(otpCode);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationPanel()));
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
