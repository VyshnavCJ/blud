import 'package:blud_frontend/widgets/historycards.dart';
import 'package:dio/dio.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';
import 'errorscreen.dart';

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
  bool pressed = false;
  late bool requested;
  final dio = Dio();
  List<dynamic> requestlist = [];
  List<dynamic> donationlist = [];
  String _selectedOption = 'Select';

  getHistory(index) async {
    try {
      setState(() {
        pressed = false;
      });
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
      setState(() {
        pressed = true;
      });
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout) {
          print('connectontimeout$e');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 40 / 727,
                    left: MediaQuery.of(context).size.width * 23 / 375),
                width: MediaQuery.of(context).size.width * 38 / 375,
                height: MediaQuery.of(context).size.height * 49 / 727,
                child: Image.asset('assets/images/blud_icon.png')),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 40 / 727,
                  left: MediaQuery.of(context).size.width * 297 / 375),
              height: MediaQuery.of(context).size.height * 43 / 727,
              width: MediaQuery.of(context).size.width * 45 / 37,
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
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 98 / 727,
                  left: MediaQuery.of(context).size.width * 27 / 375),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('History',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: MediaQuery.of(context).size.height * 20 / 727,
                        fontWeight: FontWeight.w600,
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 15 / 727),
                      width: MediaQuery.of(context).size.width * 178 / 375,
                      height: MediaQuery.of(context).size.height * 39 / 727,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB4B3),
                        borderRadius: BorderRadius.circular(30),
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
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        5 /
                                        365),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: MediaQuery.of(context).size.height *
                                        16 /
                                        727,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      )),
                  pressed
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 480 / 727,
                          width: MediaQuery.of(context).size.width * 321 / 375,
                          child: select
                              ? requested
                                  ? requestlist.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: ListView.builder(
                                            itemCount: requestlist.length,
                                            itemBuilder: (context, index) {
                                              return Historycard(
                                                  name: requestlist[index]
                                                      ["name"],
                                                  faddress: requestlist[index]
                                                      ["hospital"],
                                                  bloodGroup: requestlist[index]
                                                      ["bloodGroup"],
                                                  units: (requestlist[index]
                                                          ["units"])
                                                      .toString());
                                            },
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Request history empty",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    727),
                                          ),
                                        )
                                  : donationlist.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: ListView.builder(
                                            itemCount: donationlist.length,
                                            itemBuilder: (context, index) {
                                              return Historycard(
                                                  name: donationlist[index]
                                                      ["name"],
                                                  faddress: donationlist[index]
                                                      ["hospital"],
                                                  bloodGroup: donationlist[index]
                                                      ["bloodGroup"],
                                                  units: donationlist[index]
                                                          ["units"]
                                                      .toString());
                                            },
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Text(
                                            "Donation history empty",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    727),
                                          ),
                                        )
                              : Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    "Select an option to continue",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                13 /
                                                727),
                                  ),
                                )
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
                          )
                      : select
                          ? Container(
                              margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width - 50,
                              child: const Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xFFFF4040))),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                'Select an option to continue',
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height *
                                        13 /
                                        727),
                              ),
                            )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
