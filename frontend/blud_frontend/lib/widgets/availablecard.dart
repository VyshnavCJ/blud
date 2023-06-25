import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenAC = bloodStorage.token;
String phoneAC = bloodStorage.phoneNumber;
String requestAC = bloodStorage.requestID;

class AvailableCard extends StatefulWidget {
  final String name;
  final String faddress;
  final String bloodGroup;
  final int phonenumber;

  const AvailableCard({
    Key? key,
    required this.name,
    required this.faddress,
    required this.bloodGroup,
    required this.phonenumber,
  }) : super(key: key);

  @override
  State<AvailableCard> createState() => _AvailableCardState();
}

class _AvailableCardState extends State<AvailableCard> {
  bool openCard1 = false;
  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    _launchCaller() async {
      final url = "tel:${widget.phonenumber}";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
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
                  Text('Donor Accepted'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(top: 15),
        width: MediaQuery.of(context).size.width * 339 / 375,
        height: openCard1
            ? MediaQuery.of(context).size.height * 195 / 727
            : MediaQuery.of(context).size.height * 120 / 727,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(22)),
        child: InkWell(
            onTap: () {
              setState(() {
                openCard1 = !openCard1;
              });
            },
            borderRadius: BorderRadius.circular(22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 18),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 150 / 375,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 15 / 727,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.faddress,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 11 / 727,
                              fontFamily: "Poppins",
                              color: Color(0xff949494)),
                        ),
                        openCard1
                            ? TextButton(
                                onPressed: () {
                                  _launchCaller();
                                },
                                child: const Text(
                                  "Call Now",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Lora",
                                  ),
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 100 / 375,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 19 / 727),
                        width: MediaQuery.of(context).size.width * 48 / 375,
                        height: MediaQuery.of(context).size.height * 30 / 727,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: const Color(0xffFFE3E3),
                        ),
                        child: Center(
                            child: Text(
                          widget.bloodGroup,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 13 / 727,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFF4040)),
                        )),
                      ),
                      openCard1
                          ? TextButton(
                              onPressed: () async {
                                Response response = await dio.post(
                                    'https://blud-backend.onrender.com/api/v1/request/complete',
                                    data: {
                                      "id": requestAC,
                                      "mobileNumber": widget.phonenumber
                                    },
                                    options: Options(headers: {
                                      "Content-Type": "application/json",
                                      "Authorization": "Bearer $tokenAC",
                                    }));
                                if (response.data["success"]) {
                                  _showMyDialog();
                                }
                              },
                              child: const Text(
                                "Accepted?",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Lora",
                                ),
                              ))
                          : Container(),
                    ],
                  ),
                ),
              ],
            )));
  }
}
