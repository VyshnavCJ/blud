import 'package:flutter/material.dart';

class AvailableCard extends StatefulWidget {
  final String name;
  final String faddress;
  final String bloodGroup;

  const AvailableCard({
    Key? key,
    required this.name,
    required this.faddress,
    required this.bloodGroup,
  }) : super(key: key);

  @override
  State<AvailableCard> createState() => _AvailableCardState();
}

class _AvailableCardState extends State<AvailableCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 15),
      width: 300,
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: () {
          
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
                        fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.faddress,
                    style: const TextStyle(
                        fontSize: 11,
                        fontFamily: "Poppins",
                        color: Color(0xff949494)),
                  ),
                  TextButton(onPressed: () {},
                  child: const Text(
                          "Call Now",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Lora",
                          ),
                        )
                  ),
                  

                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 19, left: 55),
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
                        const TextStyle(fontSize: 13, fontWeight: FontWeight.w700 ,color: Color(0xFFFF4040)),
                  )),
                ),
              ],
            ),
            const SizedBox()
          ],
      )
      )
    );
      
  }
}