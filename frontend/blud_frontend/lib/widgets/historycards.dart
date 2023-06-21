import 'package:flutter/material.dart';

class Historycard extends StatefulWidget {
  final String name;
  final String faddress;
  final String bloodGroup;
  final String units;
  const Historycard({
    Key? key,
    required this.name,
    required this.faddress,
    required this.bloodGroup,
    required this.units,
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
      width: 300,
      height: 120,
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
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.faddress,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: "Poppins",
                        color: Color(0xff949494)),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 19, left: 55),
                  width: 48,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xffFF5553),
                  ),
                  child: Center(
                      child: Text(
                    widget.bloodGroup,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000)),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 53),
                  child: Row(
                    children: [
                      Text(
                        widget.units,
                        style: const TextStyle(fontFamily: "Poppins"),
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
