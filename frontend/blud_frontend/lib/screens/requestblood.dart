import 'package:blud_frontend/screens/homepage.dart';
import 'package:flutter/material.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  List<String> bloodgroups = ['Blood Group','A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  late String selectedBloodGroup;

  @override
  void initState() {
    super.initState();
    selectedBloodGroup = bloodgroups[0];
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
            child: Text('Request Blood', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w800,)),
          ),
          Container(
          margin: const EdgeInsets.only(top: 120),
          child: ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              Container(
                width: 78,
                height: 60,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(color: const Color(0xFFFFE3E3), border: Border.all(width: 1.0) ,borderRadius: BorderRadius.circular(10), ),
                child: DropdownButton<String>(
                  value: selectedBloodGroup,
                  hint: Text('Select Blood Group'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedBloodGroup = newValue!;
                    });
                  },
                  underline: Container(),
                  items: bloodgroups.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Units',
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
                  labelText: 'Full Name of Patient',
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
                  labelText: 'Mobile Number',
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
                  labelText: 'Location/Hospital Name',
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
                  labelText: 'Pincode',
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
                  labelText: 'Date',
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
                  labelText: 'Bystander Name',
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
                  labelText: 'Bleeding Place',
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
                  labelText: 'Case of Admit',
                  filled: true,
                  fillColor: Color(0xFFFFE3E3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
                ),
              ),
              const SizedBox(height: 5.0),
              Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              width: 70, height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFFF4040)
              ),
              child: const Text('PROCEED', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF000000)),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 10),
              width: 50, height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFFF4040)
              ),
              child: const Text('DROP REQUEST', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF000000)),),
            )
            ],
          )
          ),
          
        ]
      ),
    );
  }
}