// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LiveRequestCard extends StatefulWidget {
  final Function liveDonation;
  final String name;
  final String hAdrress;
  final String bloodGroup;
  final String distance;
  const LiveRequestCard({
    Key? key,
    required this.liveDonation,
    required this.name,
    required this.hAdrress,
    required this.bloodGroup,
    required this.distance,
  }) : super(key: key);

  @override
  State<LiveRequestCard> createState() => _LiveRequestCardState();
}

class _LiveRequestCardState extends State<LiveRequestCard> {
  bool opencard = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(top: 30),
      width: 330,
      height: opencard ? 160 : 110,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: () {
          setState(() {
            opencard = !opencard;
          });
        },
        borderRadius: BorderRadius.circular(22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.hAdrress,
                    style: const TextStyle(
                        fontSize: 13,
                        fontFamily: "Poppins",
                        color: Color(0xff949494)),
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 19, right: 38),
                  width: 48,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xffFFE3E3),
                  ),
                  child: Center(
                      child: Text(
                    widget.bloodGroup,
                    style:
                        const TextStyle(fontSize: 13, color: Color(0xFFFF4040)),
                  )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25, right: 35),
                  child: Row(
                    children: [
                      const Icon(Icons.near_me_rounded),
                      Text(
                        widget.distance,
                        style: const TextStyle(fontFamily: "Poppins"),
                      )
                    ],
                  ),
                ),
                opencard
                    ? TextButton(
                        style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromARGB(47, 0, 0, 0))),
                        onPressed: () => widget.liveDonation(),
                        child: const Text(
                          "Accept Now",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                          ),
                        ))
                    : Container()
              ],
            ),
            const SizedBox()
          ],
        ),
      ),
    );
  }
}
