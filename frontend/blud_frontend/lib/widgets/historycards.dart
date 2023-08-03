import 'package:flutter/material.dart';

class Historycard extends StatefulWidget {
  final String name;
  final String faddress;
  final String bloodGroup;
  final String units;
  final String date;
  const Historycard({
    Key? key,
    required this.name,
    required this.faddress,
    required this.bloodGroup,
    required this.units,
    required this.date,
  }) : super(key: key);

  @override
  State<Historycard> createState() => _HistorycardState();
}

class _HistorycardState extends State<Historycard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 300 / 375,
      height: MediaQuery.of(context).size.height * 120 / 727,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 15 / 727,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.faddress,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 11 / 727,
                        fontFamily: "Poppins",
                        color: const Color(0xff949494)),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 11 / 727,
                        fontFamily: "Poppins",
                        color: const Color(0xff949494)),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 19, left: 55),
                  width: MediaQuery.of(context).size.width * 48 / 375,
                  height: MediaQuery.of(context).size.height * 30 / 727,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xffFF5553),
                  ),
                  child: Center(
                      child: Text(
                    widget.bloodGroup,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 13 / 727,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF000000)),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 53),
                  child: Row(
                    children: [
                      Text(
                        '${widget.units} Unit(s)',
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize:
                              MediaQuery.of(context).size.height * 13 / 727,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
