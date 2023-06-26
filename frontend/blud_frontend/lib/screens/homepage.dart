// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:blud_frontend/screens/requestblood.dart';
import 'package:blud_frontend/screens/willingdonors.dart';

import '../main.dart';
import '../Hive_storage/blood_storage.dart';
import '../widgets/bloodoptions.dart';
import '../widgets/liverequestcard.dart';
import 'errorscreen.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenHP = bloodStorage.token;
String phoneHP = bloodStorage.phoneNumber;
String requestHP = bloodStorage.requestID;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List liveRequests = [];

  final dio = Dio();
  bool requested = false;
  bool canDonate = false;
  bool loaded = false;
  homeRequest() async {
    try {
      print(tokenHP);

      Response response =
          await dio.get('https://blud-backend.onrender.com/api/v1/user/home',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenHP",
              }));
      print(response);
      if (response.data['success']) {
        box.put(
            'BloodStorage',
            BloodStorage(
                token: tokenHP,
                phoneNumber: phoneHP,
                requestID: '',
                loggedin: 'yes'));

        if (response.data['data']['requestId'] == null) {
          // setState(() {
          //   requested = false;
          // });
          box.put(
              'BloodStorage',
              BloodStorage(
                  token: tokenHP,
                  phoneNumber: phoneHP,
                  requestID: '',
                  loggedin: 'yes'));
          requested = false;
        } else {
          // setState(() {
          //   requested = true;
          // });
          requested = true;

          box.put(
              'BloodStorage',
              BloodStorage(
                  token: tokenHP,
                  phoneNumber: phoneHP,
                  requestID: response.data['data']['requestId'].toString(),
                  loggedin: 'yes'));
          print(response.data['data']['requestId'].toString());
        }
        setState(() {
          canDonate = response.data['data']['canDonate'];
        });
        print(canDonate);
      }

      Response response2 =
          await dio.get('https://blud-backend.onrender.com/api/v1/request/view',
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $tokenHP",
              }));
      setState(() {
        liveRequests = response2.data['requestDetails'];
      });
      print(response2);
      print(liveRequests);
      setState(() {
        loaded = true;
      });
      print(bloodStorage.loggedin);
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout) {
          print('connectontimeout$e');
          int statusCode = e.response?.statusCode ?? 0;
          String statusmsg = e.response?.data['msg'].toString() ?? '';
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ErrorScreen(
              statusCode: statusCode,
              statusmsg: statusmsg,
              screen: 1,
            );
          }));
        } else if (e.type == DioExceptionType.sendTimeout) {
          print('senttimeout$e');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('receivetimeout$e');
        } else if (e.type == DioExceptionType.badResponse) {
          int statusCode = e.response?.statusCode ?? 0;
          String statusmsg = e.response?.data['msg'].toString() ?? '';
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ErrorScreen(
              statusCode: statusCode,
              statusmsg: statusmsg,
              screen: 1,
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Request Accepted'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve',
                  style: TextStyle(color: Color(0xFFFF4040))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    homeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  top: MediaQuery.of(context).size.height * 111 / 727),
              height: MediaQuery.of(context).size.height * 575 / 727,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BloodOptions(
                          headText: !requested
                              ? "Request\nBlood"
                              : "You have\nRequested",
                          active: !requested,
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RequestBlood()))
                                .then((_) => const HomePage());
                          }),
                      BloodOptions(
                          headText: requested
                              ? "Willing\nDonors"
                              : "Request to\nview Donors",
                          active: requested,
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WillingDonor()))
                                .then((_) => const HomePage());
                          })
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 70 / 727,
                        right: MediaQuery.of(context).size.width * 145 / 375),
                    child: Text(
                      "Live Requests",
                      style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.height * 25 / 727,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 323 / 727,
                    child: loaded
                        ? canDonate
                            ? liveRequests.isEmpty
                                ? Container(
                                    margin: const EdgeInsets.all(30),
                                    child: Text(
                                      "No Live Requests right now.",
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              15 /
                                              727,
                                          color: Colors.black38),
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                25 /
                                                375,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                25 /
                                                375),
                                    child: ListView.builder(
                                        itemCount: liveRequests.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return LiveRequestCard(
                                            name: liveRequests[index]['name'],
                                            hAdrress: liveRequests[index]
                                                ['hospital'],
                                            bloodGroup: liveRequests[index]
                                                ['bloodGroup'],
                                            distance:
                                                '${liveRequests[index]['distance'].toString().length > 3 ? liveRequests[index]['distance'].toString().substring(0, 3) : liveRequests[index]['distance'].toString()}km',
                                            units: liveRequests[index]['units']
                                                .toString(),
                                            liveDonation: () async {
                                              await dio.post(
                                                  'https://blud-backend.onrender.com/api/v1/request/accept',
                                                  data: {
                                                    "id": liveRequests[index]
                                                        ['_id']
                                                  },
                                                  options: Options(headers: {
                                                    "Content-Type":
                                                        "application/json",
                                                    "Authorization":
                                                        "Bearer $tokenHP",
                                                  }));
                                              _showMyDialog();
                                              homeRequest();
                                            },
                                          );
                                          // return Text(liveRequests[index].title);
                                        }),
                                  )
                            // LiveRequestCard(
                            //   name: "Raquel Brummock",
                            //   hAdrress: "Merlyn Medical\nCentre,\nAlexandria",
                            //   bloodGroup: "B+ve",
                            //   distance: '0.5m',
                            //   liveDonation: () {},
                            // ),

                            : Container(
                                margin: const EdgeInsets.all(30),
                                child: Text(
                                    "No compactible request with your current donation status",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                15 /
                                                727,
                                        color: Colors.black38)),
                              )
                        : const Center(
                            child: CircularProgressIndicator(
                            color: Color(0xFF802120),
                          )),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(top: 341),
            //   height: 100,
            //   decoration: const BoxDecoration(
            //       gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [
            //       Color(0xFFFFFBF1),
            //       Color(0x00FFFBF1),
            //       Color(0x00000000),
            //     ],
            //   )),
            // ),
          ],
        ),
      ),
    );
  }
}
