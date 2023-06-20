import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Hive_storage/blood_storage.dart';
import '../main.dart';

BloodStorage bloodStorage = box.get("BloodStorage");
String tokenRB = bloodStorage.token;
String phoneRB = bloodStorage.phoneNumber;
String requestRB = bloodStorage.requestID;

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final dio = Dio();
  requestbloodfunc(name, bleeding, hospital, pincode, units, bystander, case_,
      bloodgroup,date,time, context) async {

    Response response = await dio.post(
        'https://blud-backend.onrender.com/api/v1/request/create',
        data: {
          "name": name,
          "bleedingPlace": bleeding,
          "hospital": hospital,
          "pinCode": pincode,
          "units": units,
          "bystander": bystander,
          "case": case_,
          "bloodGroup": bloodgroup,
          "date":
              date,
          "time": time
        },
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $tokenRB",
        }));
    if (response.data['success']) {
      box.put(
          'BloodStorage',
          BloodStorage(
              token: tokenRB,
              phoneNumber: phoneRB,
              requestID: response.data['requestId'].toString(),loggedin: true));
      _showMyDialog();
      Navigator.pop(context);
    } else {}
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Put up'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your Blood Request has been registered'),
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

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController bgcontroller = TextEditingController();
  final TextEditingController unitscontroller = TextEditingController();
  final TextEditingController loccontroller = TextEditingController();
  final TextEditingController pincontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  final TextEditingController bystandercontroller = TextEditingController();
  final TextEditingController bleedingplacecontroller = TextEditingController();
  final TextEditingController casecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
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
          child: const Text('Request Blood',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w800,
              )),
        ),
        Container(
            margin: const EdgeInsets.only(top: 150),
            child: ListView(
              padding: const EdgeInsets.all(15.0),
              children: [
                CustomTextField(controller: bgcontroller, text: 'Blood Group'),
                const SizedBox(height: 12.0),
                CustomTextField(controller: unitscontroller, text: 'Units'),
                const SizedBox(height: 12.0),
                CustomTextField(
                    controller: namecontroller, text: 'Full Name of Patient'),
                const SizedBox(height: 12.0),
                CustomTextField(
                    controller: loccontroller, text: 'Location/Hospital Name'),
                const SizedBox(height: 12.0),
                CustomTextField(controller: pincontroller, text: 'Pincode'),
                const SizedBox(height: 12.0),
                CustomTextField(
                    controller: bystandercontroller, text: 'Bystander Name'),
                const SizedBox(height: 12.0),
                CustomTextField(
                    controller: bleedingplacecontroller,
                    text: 'Bleeding Place'),
                    const SizedBox(height: 12.0),
                CustomTextField(
                    controller: datecontroller,
                    text: 'Date'),
                    const SizedBox(height: 12.0),
                CustomTextField(
                    controller: timecontroller,
                    text: 'Time'),
                const SizedBox(height: 12.0),
                CustomTextField(
                    controller: casecontroller, text: 'Case of Admit'),
                const SizedBox(height: 15.0),
                SizedBox(
                    width: 50,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: () {
                          requestbloodfunc(
                              namecontroller.text.toString(),
                              bleedingplacecontroller.text.toString(),
                              loccontroller.text.toString(),
                              pincontroller.text.toString(),
                              int.parse(unitscontroller.text),
                              bystandercontroller.text.toString(),
                              casecontroller.text.toString(),
                              bgcontroller.text.toString(),
                              datecontroller.text.toString(),
                              int.parse(timecontroller.text),
                              context);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFFF4040))),
                        child: const Text('Proceed')))
              ],
            ))
      ]),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
  });

  final TextEditingController controller;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: text,
          filled: true,
          fillColor: const Color(0xFFFFE3E3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
