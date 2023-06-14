import 'package:blud_frontend/screens/homepage.dart';
import 'package:blud_frontend/widgets/availablecard.dart';
import 'package:flutter/material.dart';

class WillingDonor extends StatefulWidget {
  const WillingDonor({super.key});

  @override
  State<WillingDonor> createState() => _WillingDonorState();
}

class _WillingDonorState extends State<WillingDonor> {
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
            width: 60, height: 37,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xFFFF4040)
            ),
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
            child: Text('Available Donors', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w800,)),
          ),
          const Positioned(
            top: 105, left: 25,
            child: SizedBox(
              height: 700,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    AvailableCard(name: "Raquel Brummock", faddress: "Merlyn Medical\nCentre,\nAlexandria\n(171001)", bloodGroup: "AB+"),
                    AvailableCard(name: "Jennifer Abraham", faddress: "Oliver Hospital\nBrooklyn,\nUSA\n(121081)", bloodGroup: "B-"),
                    AvailableCard(name: "Jinash Jaleel", faddress: "Medical Hospital\nKochi\nIndia\n(628301)", bloodGroup: "O-"),
                    AvailableCard(name: "Cee Jay", faddress: "Medical Hospital\nKochi\nIndia\n(628301)", bloodGroup: "O-"),
                    AvailableCard(name: "Cee Jay", faddress: "Medical Hospital\nKochi\nIndia\n(628301)", bloodGroup: "O-"),
                    AvailableCard(name: "Cee Jay", faddress: "Medical Hospital\nKochi\nIndia\n(628301)", bloodGroup: "O-"),
                  ],
                ),
              ),
            )
            )


        ],
      ),
    );
  }
}