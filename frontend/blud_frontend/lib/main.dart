import 'package:blud_frontend/Hive_storage/blood_storage.dart';
import 'package:blud_frontend/screens/navigation.dart';
import 'package:blud_frontend/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(BloodStorageAdapter());
  }
  box = await Hive.openBox('box');

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  Future<void> initbox() async {
    box = await Hive.openBox('box');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initbox();
  }

  @override
  Widget build(BuildContext context) {
    BloodStorage? bloodStorage = box.get("BloodStorage");
    String login = bloodStorage?.loggedin ?? '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFFFBF1),
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (login == 'yes') {
              return const NavigationPanel();
            } else {
              return const Splash();
            }
          } else if (snapshot.hasError) {
            return const Center(child: Text('ERROR'));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
