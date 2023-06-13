import 'package:flutter/material.dart';

class UserReg extends StatefulWidget {
  const UserReg({super.key});

  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
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
                left: MediaQuery.of(context).size.width - 170),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120, left: 25),
            child: Text('USER REGISTRATION', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF700606)),),
          ),
          const Positioned(
            top: 160, left: 135,
            child: CircleAvatar(radius: 45,
            backgroundColor: Color(0xFFFFABAB),)
            
          ),
          Container(
          margin: EdgeInsets.only(top: 250),
          child: ListView(
            padding: EdgeInsets.all(15.0),
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0,),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Blood Group',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number(should be available in Whatsapp and used for verification)',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Secondary Contact Number',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'E-Mail',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'District',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'State',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              SizedBox(height: 15.0),
              Container(
              width: 50, height: 30,
              child: ElevatedButton(onPressed: (){

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFFFF4040))
              ),
              child: Text('Create Profile'))
              )
            ],
          )
          )
        ],
      ),
    );
  }
}