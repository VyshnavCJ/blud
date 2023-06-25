// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../Hive_storage/blood_storage.dart';
import '../main.dart';

class ErrorScreen extends StatelessWidget {
  final int statusCode;
  final String statusmsg;
  final int screen;
  const ErrorScreen(
      {super.key,
      required this.statusCode,
      required this.statusmsg,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mood_bad_rounded, size: 90),
            Transform.rotate(
              angle: -0.2,
              child: Text(
                statusCode.toString(),
                style: const TextStyle(fontSize: 170, color: Colors.black38),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(
                statusmsg,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.black38),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              color: const Color(0xffFF4040),
              child: TextButton(
                  onPressed: () {
                    print('object');
                    box.put(
                        'BloodStorage',
                        BloodStorage(
                            token: '',
                            phoneNumber: '',
                            requestID: "",
                            loggedin: 'no'));
                    box.clear();
                    box.close();
                    box.deleteFromDisk();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainApp()));
                  },
                  child: const Text(
                    'Click Me To Retry',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
