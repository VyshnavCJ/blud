import 'package:blud_frontend/Hive_storage/blood_storage.dart';
import 'package:blud_frontend/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(BloodStorageAdapter());
  runApp(MainApp());
}

class MainApp extends StatelessWidget {

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: const Color(0xFFFFFBF1)),
        home: const Splash());
  }
}
