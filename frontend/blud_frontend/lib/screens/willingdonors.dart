import 'package:blud_frontend/widgets/availablecard.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenWD = bloodStorage.token;
String phoneWD = bloodStorage.phoneNumber;
String requestWD = bloodStorage.requestID;

class WillingDonor extends StatefulWidget {
  const WillingDonor({super.key});

  @override
  State<WillingDonor> createState() => _WillingDonorState();
}

class _WillingDonorState extends State<WillingDonor> {
  final _database = FirebaseDatabase.instance.ref();
  var donorData;
  var filteredDonorData;
  bool pressed = false;
  final dio = Dio();
  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  _activateListeners() async {
    await _database.child('response').onValue.listen((event) {
      setState(() {
        donorData = event.snapshot.value;
        print(donorData);
        filteredDonorData = donorData[requestWD.toString()];
        print(filteredDonorData);
        print(filteredDonorData.values);
        pressed = true;
      });
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
                Text('Drop Request?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok',
                  style: TextStyle(color: const Color(0xFFFF4040))),
              onPressed: () async {
                Navigator.of(context).pop();
                Response response = await dio.delete(
                    'https://blud-backend.onrender.com/api/v1/request/cancel',
                    data: {"id": requestWD},
                    options: Options(headers: {
                      "Content-Type": "application/json",
                      "Authorization": "Bearer $tokenWD",
                    }));
                if (response.data['success']) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _activateListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                top: MediaQuery.of(context).size.height * 40 / 727,
                left: MediaQuery.of(context).size.width * 18 / 375),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 60 / 375,
                      height: MediaQuery.of(context).size.height * 40 / 727,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color(0xFFFF4040)),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: const Icon(Icons.arrow_back_rounded),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25),
                      child: Text('Available Donors',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:
                                MediaQuery.of(context).size.height * 20 / 727,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, top: 25),
                  child: InkWell(
                    onTap: () {
                      _showMyDialog();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.dnd_forwardslash_sharp),
                        Text(
                          'Drop Request',
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 15 / 727,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                pressed
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 600 / 727,
                        width: MediaQuery.of(context).size.width * 309 / 375,
                        child: donorData != null
                            ? ListView.builder(
                                itemCount: filteredDonorData.values.length,
                                itemBuilder: (context, index) {
                                  return AvailableCard(
                                      name: filteredDonorData.values
                                          .elementAt(index)['name']
                                          .toString(),
                                      faddress: filteredDonorData.values
                                          .elementAt(index)['location']
                                          .toString(),
                                      bloodGroup: filteredDonorData.values
                                          .elementAt(index)["bloodGroup"]
                                          .toString(),
                                      phonenumber: int.parse(filteredDonorData
                                          .values
                                          .elementAt(index)["mobileNumber"]
                                          .toString()));
                                },
                              )
                            : const Text('No Donors Found'))
                    : const Center(
                        child: FittedBox(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF4040),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
