import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  String _selectedOption = 'Select';

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
                left: MediaQuery.of(context).size.width - 130),
            width: 170,
            height: 245,
            child: Image.asset('assets/images/lower_right_image.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 98, left: 27),
            child: const Text('History', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600,)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 145, left: 23),
            width: 128,
            height: 39,
            decoration: BoxDecoration(color: const Color(0xFFFFB4B3), borderRadius: BorderRadius.circular(20), ),
            child: Center(child: DropdownButton<String>(value: _selectedOption,
            onChanged: (String? newValue){
              setState(() {
                _selectedOption = newValue!;
              });
            },
            items: <String>['Select', 'REQUESTS', 'DONATIONS'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.normal,),),
              );
            }).toList(),
            ),
          )
          )
        ],
      ),
    );
  }
}

