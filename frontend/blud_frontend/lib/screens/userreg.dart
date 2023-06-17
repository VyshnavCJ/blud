import 'package:flutter/material.dart';

class UserReg extends StatefulWidget {
  const UserReg({super.key});

  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  String _gender = 'Gender';
  String _bloodgroup = 'Blood Group';
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
            child: const Text('USER REGISTRATION', style: TextStyle(fontFamily: 'Poppins', fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF700606)),),
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
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(border: Border.all(width: 1.0), borderRadius: BorderRadius.circular(10.0), color: Color(0xFFFFE3E3)),
                child: DropdownButton<String>(
                value: _gender,
                hint: Text('Select Gender'),
                onChanged: (String? newValue) {
                  setState(() {
                    _gender = newValue!;
                  });
                },
                underline: Container(),
                items: <String>['Gender', 'Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400)),
                  );
                }).toList(),
                alignment: Alignment.center,
              ),
              ),
              SizedBox(height: 12.0,),
              Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(border: Border.all(width: 1.0), borderRadius: BorderRadius.circular(10.0), color: Color(0xFFFFE3E3)),
                child: DropdownButton<String>(
                value: _bloodgroup,
                hint: Text('Select Blood Group'),
                onChanged: (String? newValue) {
                  setState(() {
                    _bloodgroup = newValue!;
                  });
                },
                underline: Container(),
                items: <String>['Blood Group', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400)),
                  );
                }).toList(),
                alignment: Alignment.center,
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