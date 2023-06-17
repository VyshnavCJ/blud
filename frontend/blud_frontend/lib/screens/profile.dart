import 'package:flutter/material.dart';
import 'package:blud_frontend/screens/userreg.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            child: const Text('Profile', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600,)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 165, left: 100),
            child: const Text('Raquel Brummock', style: TextStyle(fontFamily: 'Poppins', fontSize: 21, fontWeight: FontWeight.bold,)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 235, left: 25),
            child: const Text('Personal Details', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF802120))),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserReg()));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 235, left: 300),
            child: const Text('EDIT', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF802120), decoration: TextDecoration.underline),),
            )
          ),
          
          const Positioned(
            top: 145, left: 20,
            child: CircleAvatar(radius: 35,
            backgroundColor: Color(0xFFFFABAB),)
          ),
          Container(
            margin: const EdgeInsets.only(top: 265, left: 23),
            width: 310, height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF000000),
                width: 1.0
              )
            ),
            padding: const EdgeInsets.all(16.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Raquel Brummock', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
                SizedBox(height: 7),
                Text('+911234567890', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
                SizedBox(height: 7),
                Text('Address', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
                SizedBox(height: 7),
                Text('Age: 22', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
                SizedBox(height: 7),
                Text('Blood Group', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
                SizedBox(height: 7),
                Text('Gender', style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color(0xFF949292)),),
              ],
            ),    
          )
        ],
      ),
    );
  }
}