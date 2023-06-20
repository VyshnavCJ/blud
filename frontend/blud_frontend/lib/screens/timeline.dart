import 'package:blud_frontend/widgets/historycards.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenTL = bloodStorage.token;
String phoneTL = bloodStorage.phoneNumber;
String requestTL = bloodStorage.requestID;

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  bool select = false;
  late bool requested;
  final dio = Dio();
  List<dynamic> requestlist = [];
  List<dynamic> donationlist = [];
  String _selectedOption = 'Select';

  getHistory(index) async {
    if (index == 1) {
      Response response = await dio.get(
          'https://blud-backend.onrender.com/api/v1/user/history/$index',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $tokenTL",
          }));
      print(response);
      setState(() {
        requestlist = response.data['data'];
      });
    } else {
      Response response = await dio.get(
          'https://blud-backend.onrender.com/api/v1/user/history/$index',
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $tokenTL",
          }));
      print(response);
      setState(() {
        donationlist = response.data['data'];
      });
    }
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
            child: const Text('History',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                )),
          ),
          Container(
              margin: const EdgeInsets.only(top: 145, left: 23),
              width: 128,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB4B3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: DropdownButton<String>(
                  value: _selectedOption,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedOption = newValue!;
                      select = true;
                      if (_selectedOption == 'REQUESTS') {
                        setState(() {
                          requested = true;
                        });
                        getHistory(1);
                      } else if (_selectedOption == 'DONATIONS') {
                        setState(() {
                          requested = false;
                        });
                        getHistory(2);
                      }
                    });
                  },
                  items: <String>['Select', 'REQUESTS', 'DONATIONS']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )),
          Positioned(
              top: 205,
              left: 25,
              child: SizedBox(
                  height: 800,
                  width: MediaQuery.of(context).size.width - 50,
                  child: select
                      ? requested
                          ? requestlist.isNotEmpty? ListView.builder(
                              itemCount: requestlist.length,
                              itemBuilder: (context, index) {
                                return Historycard(
                                    name: requestlist[index]["name"],
                                    faddress: requestlist[index]["hospital"],
                                    bloodGroup: requestlist[index]
                                        ["bloodGroup"],
                                    units: (requestlist[index]["units"])
                                        .toString());
                              },
                            ):const Text("Request history empty")
                          : donationlist.isNotEmpty?ListView.builder(
                              itemCount: donationlist.length,
                              itemBuilder: (context, index) {
                                return Historycard(
                                    name: donationlist[index]["name"],
                                    faddress: donationlist[index]["hospital"],
                                    bloodGroup: donationlist[index]
                                        ["bloodGroup"],
                                    units: donationlist[index]["units"]
                                        .toString());
                              },
                            ):const Text("Donation history empty")
                      : const Text("Select an option to continue")
                  // child: SingleChildScrollView(
                  //   child: Column(
                  //     children: [
                  //       SizedBox(height: 5),
                  //       Historycard(
                  //           name: "Raquel Brummock",
                  //           faddress:
                  //               "Merlyn Medical\nCentre,\nAlexandria\n(171001)",
                  //           bloodGroup: "AB+",
                  //           units: "2 units"),
                  //     ],
                  //   ),
                  // ),
                  ))
        ],
      ),
    );
  }
}
