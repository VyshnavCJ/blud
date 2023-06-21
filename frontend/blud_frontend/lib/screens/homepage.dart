// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blud_frontend/screens/requestblood.dart';
import 'package:blud_frontend/screens/willingdonors.dart';

import '../main.dart';
import '../Hive_storage/blood_storage.dart';
import '../widgets/bloodoptions.dart';
import '../widgets/liverequestcard.dart';

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
  List liveRequests=[];

  final dio = Dio();
  bool requested = false;
  bool canDonate = false;
  bool loaded = false;
  homeRequest() async {
    print(tokenHP);

    Response response =
        await dio.get('https://blud-backend.onrender.com/api/v1/user/home',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $tokenHP",
            }));
    print(response);
    if (response.data['success']) {
      if (response.data['data']['requestId'] == null) {
        setState(() {
          requested = false;
        });
      } else {
        setState(() {
          requested = true;
        });

        box.put(
            'BloodStorage',
            BloodStorage(
                token: tokenHP,
                phoneNumber: phoneHP,
                requestID: response.data['data']['requestId'].toString(),loggedin: 'yes'));
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
              child: const Text('Approve'),
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
                              .then((value) => homeRequest());
                        })
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 70, right: 145),
                  child: const Text(
                    "Live Requests",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 378,
                  child: loaded?canDonate
                      ? liveRequests.isEmpty
                          ? Container(
                              margin: const EdgeInsets.all(30),
                              child: const Text("No Live Requests right now."),
                            )
                          : Container(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25),
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
                                                '${liveRequests[index]['distance']}km',
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
                          child: const Text(
                              "No compactible request with your current donation status"),
                        ):const Center(child: CircularProgressIndicator(color: Color(0xFF802120),)),
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
