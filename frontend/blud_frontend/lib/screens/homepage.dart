// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import '../widgets/bloodoptions.dart';
import '../widgets/liverequestcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            margin: const EdgeInsets.only(top: 111),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BloodOptions(
                        headText: "Request\nBlood",
                        onTap: () {
                          print("REQUEST BLOOD");
                        }),
                    BloodOptions(
                      headText: "Willing\nDonors",
                      onTap: () {
                        print("WILLING DONORS");
                      },
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70, right: 170),
                  child: const Text(
                    "Live Requests",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 378,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        LiveRequestCard(
                          name: "Raquel Brummock",
                          hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                          bloodGroup: "B+ve",
                          distance: '0.5m',
                          liveDonation: () {},
                        ),
                        LiveRequestCard(
                          name: "Raquel Brummock",
                          hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                          bloodGroup: "B+ve",
                          distance: '0.5m',
                          liveDonation: () {},
                        ),
                        LiveRequestCard(
                          name: "Raquel Brummock",
                          hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                          bloodGroup: "B+ve",
                          distance: '0.5m',
                          liveDonation: () {},
                        ),
                        LiveRequestCard(
                          name: "Raquel Brummock",
                          hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                          bloodGroup: "B+ve",
                          distance: '0.5m',
                          liveDonation: () {},
                        ),
                        LiveRequestCard(
                          name: "Raquel Brummock",
                          hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                          bloodGroup: "B+ve",
                          distance: '0.5m',
                          liveDonation: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 341),
            height: 100,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFBF1),
                Color(0x00FFFBF1),
                Color(0x00000000),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
