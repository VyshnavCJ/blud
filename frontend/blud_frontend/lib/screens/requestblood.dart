import 'package:blud_frontend/widgets/date_selector.dart';
import 'package:blud_frontend/widgets/time_selector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../Hive_storage/blood_storage.dart';
import '../main.dart';
import 'errorscreen.dart';

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
  String bgDD = 'Blood Group';
  bool pressed = false;
  final dio = Dio();

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController unitscontroller = TextEditingController();
  final TextEditingController loccontroller = TextEditingController();
  final TextEditingController pincontroller = TextEditingController();
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController timecontroller = TextEditingController();
  final TextEditingController bystandercontroller = TextEditingController();
  final TextEditingController bleedingplacecontroller = TextEditingController();
  final TextEditingController casecontroller = TextEditingController();
  requestbloodfunc(name, bleeding, hospital, pincode, units, bystander, case_,
      bloodgroup, date, time, context) async {
    try {
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
            "date": date,
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
                requestID: response.data['requestId'].toString(),
                loggedin: 'yes'));
        _showMyDialog();
        Navigator.pop(context);
      } else {}
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout) {
          print('connectontimeout$e');
          int statusCode = e.response?.statusCode ?? 0;
          String statusmsg = e.response?.data['msg'] ?? '';
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ErrorScreen(
              statusCode: statusCode,
              statusmsg: statusmsg,
              screen: 1,
            );
          }));
        } else if (e.type == DioExceptionType.sendTimeout) {
          print('senttimeout$e');
        } else if (e.type == DioExceptionType.receiveTimeout) {
          print('receivetimeout$e');
        } else if (e.type == DioExceptionType.badResponse) {
          int statusCode = e.response?.statusCode ?? 0;
          String statusmsg = e.response?.data['msg'].toString() ?? '';
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return ErrorScreen(
              statusCode: statusCode,
              statusmsg: statusmsg,
              screen: 1,
            );
          }));
        } else if (e.type == DioExceptionType.cancel) {
          print('cancle$e');
        } else {
          print('else$e');
        }
      } else {
        print("other$e");
      }
    }
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
              child: const Text('Approve',
                  style: TextStyle(color: const Color(0xFFFF4040))),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 40 / 727,
              left: MediaQuery.of(context).size.width * 18 / 375),
          width: MediaQuery.of(context).size.width * 339 / 375,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(top: 40, left: 18),
                      width: MediaQuery.of(context).size.width * 60 / 375,
                      height: MediaQuery.of(context).size.height * 37 / 727,
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
                      margin: const EdgeInsets.only(left: 15),
                      child: Text('Request Blood',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize:
                                MediaQuery.of(context).size.height * 20 / 727,
                            fontWeight: FontWeight.w800,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 600 / 727,

                  // margin: const EdgeInsets.only(top: 150),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 339 / 375,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE3E3),
                            border: Border.all(width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                              value: bgDD,
                              hint: Text('Select Blood Group'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  bgDD = newValue!;
                                });
                              },
                              underline: Container(),
                              items: [
                                'Blood Group',
                                'A+',
                                'A-',
                                'B+',
                                'B-',
                                'AB+',
                                'AB-',
                                'O+',
                                'O-'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: const TextStyle(
                                          color: Color(0xFF700606))),
                                );
                              }).toList()),
                        ),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: unitscontroller, text: 'Units'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: namecontroller,
                            text: 'Full Name of Patient'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: loccontroller,
                            text: 'Location/Hospital Name'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: pincontroller, text: 'Pincode'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: bystandercontroller,
                            text: 'Bystander Name'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: bleedingplacecontroller,
                            text: 'Blood Bank Location'),
                        const SizedBox(height: 12.0),
                        DateofBirthTextField(
                            textEditingController: datecontroller,
                            displaytext: 'Last Date'),
                        // CustomTextField(controller: datecontroller, text: 'Date'),
                        const SizedBox(height: 12.0),
                        TimePickerTextField(
                            textEditingController: timecontroller),
                        // CustomTextField(controller: timecontroller, text: 'Time'),
                        const SizedBox(height: 12.0),
                        CustomTextField(
                            controller: casecontroller, text: 'Case of Admit'),
                        const SizedBox(height: 15.0),
                        SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 150 / 375,
                            height:
                                MediaQuery.of(context).size.height * 50 / 727,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    pressed = true;
                                  });
                                  requestbloodfunc(
                                      namecontroller.text.toString(),
                                      bleedingplacecontroller.text.toString(),
                                      loccontroller.text.toString(),
                                      pincontroller.text.toString(),
                                      int.parse(unitscontroller.text),
                                      bystandercontroller.text.toString(),
                                      casecontroller.text.toString(),
                                      bgDD,
                                      datecontroller.text.toString(),
                                      int.parse(timecontroller.text),
                                      context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xFFFF4040))),
                                child: pressed
                                    ? const SizedBox(
                                        height: 20,
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Apply Request',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                15 /
                                                727),
                                      ))),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ))
            ],
          ),
        ),
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
          labelStyle: TextStyle(color: Color(0xFF700606)),
          filled: true,
          fillColor: const Color(0xFFFFE3E3),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Color(0xFF700606))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Color(0xFF700606)))),
    );
  }
}
