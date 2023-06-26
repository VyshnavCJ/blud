import 'package:blud_frontend/screens/homepage.dart';
import 'package:blud_frontend/screens/profile.dart';
import 'package:blud_frontend/screens/timeline.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatelessWidget {
  const NavigationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFFFFBF1)),
      home: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          bottomNavigationBar: menu(context),
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text(
                'Tap back again to leave',
                style: TextStyle(color: Colors.white),
              ),
            ),
            child: TabBarView(
              children: [
                const TimeLine(),
                const HomePage(),
                Profile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menu(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 60 / 727,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const TabBar(
        labelColor: Colors.black,
        // unselectedLabelColor: Colors.white70,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Color(0xffFF4040)),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.fromLTRB(30, 5, 30, 5),
        tabs: [
          Tab(
            icon: Icon(Icons.compare_arrows_rounded),
          ),
          Tab(
            icon: Icon(Icons.home_rounded),
          ),
          Tab(
            icon: Icon(Icons.person_2_rounded),
          ),
        ],
      ),
    );
  }
}
