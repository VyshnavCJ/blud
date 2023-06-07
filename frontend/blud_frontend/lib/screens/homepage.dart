// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

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
                left: MediaQuery.of(context).size.width - 170),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 330,
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(22)),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 18),
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Raquel Brummock",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Merlyn Medical\nCentre,\nAlexandria",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Lora",
                                        color: Color(0xff949494)),
                                  )
                                ],
                              ),
                            ),
                            Column(
                            children: [Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(14),color: const Color(0xffFFE3E3),
),child: Text("B+ve"),)],
                           )
                          ],
                        ),
                      )
                    ],
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

class BloodOptions extends StatelessWidget {
  final String headText;
  final Function onTap;
  const BloodOptions({
    super.key,
    required this.headText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 125,
      decoration: BoxDecoration(
          border: Border.all(),
          color: const Color(0xffFFE3E3),
          borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              headText,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () => onTap(),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              margin: const EdgeInsets.only(left: 92),
              width: 50,
              height: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffFF4040)),
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          )
        ],
      ),
    );
  }
}
