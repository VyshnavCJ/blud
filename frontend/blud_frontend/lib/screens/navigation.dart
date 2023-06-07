import 'package:blud_frontend/screens/homepage.dart';
import 'package:blud_frontend/screens/profile.dart';
import 'package:blud_frontend/screens/timeline.dart';
import 'package:flutter/material.dart';

class NavigationPanel extends StatelessWidget {
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
          bottomNavigationBar: menu(),
          body: const TabBarView(
            children: [
              TimeLine(),
              HomePage(),
              Profile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      width: 40,
      height: 60,
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
