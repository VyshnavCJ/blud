import 'package:blud_frontend/main.dart';
import 'package:blud_frontend/screens/navigation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Hive_storage/blood_storage.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenREG = bloodStorage.token;
String phoneREG = bloodStorage.phoneNumber;
String requestREG = bloodStorage.requestID;
late Response response;
final dio = Dio();
createUser(
    name, address, pincode, district, state, dob, gender, bg, context) async {
  response =
      await dio.post('https://blud-backend.onrender.com/api/v1/user/create',
          data: {
            "name": name,
            "address": address,
            "pinCode": pincode,
            "district": district,
            "state": state,
            "dob": dob,
            "gender": gender,
            "bloodGroup": bg
          },
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $tokenREG",
          }));
  if (response.data["success"]) {
    box.put(
        'BloodStorage',
        BloodStorage(
            token: response.data["token"].toString(),
            phoneNumber: phoneREG,
            requestID: requestREG,
            loggedin: false));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationPanel(),
        ));
  } else {}
  print(response);
}

class UserReg extends StatefulWidget {
  const UserReg({super.key});

  @override
  State<UserReg> createState() => _UserRegState();
}

class _UserRegState extends State<UserReg> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController gendercontroller = TextEditingController();
  final TextEditingController bgcontroller = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController districtcontroller = TextEditingController();
  final TextEditingController statecontroller = TextEditingController();
  final TextEditingController pincodecontroller = TextEditingController();
  String? name;
  String? gender;
  String? bg;
  String? dob;
  String? address;
  String? district;
  String? state;
  int? pincode;

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
            child: const Text(
              'USER REGISTRATION',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF700606)),
            ),
          ),
          // const Positioned(
          //   top: 160, left: 135,
          //   child: CircleAvatar(radius: 45,
          //   backgroundColor: Color(0xFFFFABAB),)

          // ),
          Container(
              margin: const EdgeInsets.only(top: 190),
              child: ListView(
                padding: const EdgeInsets.all(15.0),
                children: [
                  TextField(
                    controller: namecontroller,
                    decoration: InputDecoration(
                        labelText: 'Full Name',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: gendercontroller,
                    decoration: InputDecoration(
                        labelText: 'Gender',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextField(
                    controller: bgcontroller,
                    decoration: InputDecoration(
                        labelText: 'Blood Group',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: dobcontroller,
                    decoration: InputDecoration(
                        labelText: 'DOB',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: addresscontroller,
                    decoration: InputDecoration(
                        labelText: 'Address',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: districtcontroller,
                    decoration: InputDecoration(
                        labelText: 'District',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: statecontroller,
                    decoration: InputDecoration(
                        labelText: 'State',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: pincodecontroller,
                    decoration: InputDecoration(
                        labelText: 'Pincode',
                        filled: true,
                        fillColor: const Color(0xFFFFE3E3),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                      width: 50,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {
                            name = namecontroller.text.toString();
                            address = addresscontroller.text.toString();
                            pincode = int.parse(pincodecontroller.text);
                            district = districtcontroller.text.toString();
                            state = statecontroller.text.toString();
                            dob = dobcontroller.text.toString();
                            gender = gendercontroller.text.toString();
                            bg = bgcontroller.text.toString();
                            createUser(name, address, pincode, district, state,
                                dob, gender, bg, context);
                            box.put(
                                'BloodStorage',
                                BloodStorage(
                                    token: response.data["token"].toString(),
                                    phoneNumber: phoneREG,
                                    requestID: requestREG,
                                    loggedin: true));
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFFF4040))),
                          child: const Text('Create Profile')))
                ],
              ))
        ],
      ),
    );
  }
}
