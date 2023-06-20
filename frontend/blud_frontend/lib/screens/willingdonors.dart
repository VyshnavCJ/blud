import 'package:blud_frontend/widgets/availablecard.dart';
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
  List filteredDonorData=[];

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  Future<void> _activateListeners() async {
    await _database.child('response').onValue.listen((event) {
      setState(() {
        donorData = event.snapshot.value;
        filteredDonorData = donorData[requestWD];
      });
    });
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
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height - 245,
                left: MediaQuery.of(context).size.width - 170),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 18),
            width: 60,
            height: 37,
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
            margin: const EdgeInsets.only(top: 45, left: 87),
            child: const Text('Available Donors',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                )),
          ),
          Positioned(
              top: 105,
              left: 25,
              child: SizedBox(
                  height: 700,
                  width: MediaQuery.of(context).size.width,
                  child: filteredDonorData.isNotEmpty
                      ? ListView.builder(
                          itemCount: donorData.length,
                          itemBuilder: (context, index) {
                            return AvailableCard(
                                name: donorData[index][0]['name'],
                                faddress: donorData[index][0]['location'],
                                bloodGroup: donorData[index][0]["bloodGroup"]);
                          },
                        )
                      : const Text('No Donors Found')))
        ],
      ),
    );
  }
}
