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
  bool opencard1 = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(top: 15),
      width: 300,
      height: opencard1 ? 195 : 120,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: () {
          setState(() {
            opencard1 = !opencard1;
          });
        },
        borderRadius: BorderRadius.circular(22),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10),
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
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 22, right: 1),
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
                opencard1
                ? TextButton(
                  style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromARGB(47, 0, 0, 0))),
                  onPressed: () {
                    
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call, size: 18, color: Color(0xFF000000),),
                      Text("Call Now", style: TextStyle(color: Color(0xFF000000), fontFamily: 'Poppins'),)
                    ],
                  )

                )
                
                :Container(),
                opencard1
                ? TextButton(
                  style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(
                                Color.fromARGB(47, 0, 0, 0))),
                  onPressed: () {
                    
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.verified_user_outlined, size: 18, color: Color(0xFF000000),),
                      Text("Accepted?", style: TextStyle(color: Color(0xFF000000), fontFamily: 'Poppins'),)
                    ],
                  )

                )
                
                :Container()
                
              ],
            ),
            const SizedBox()
          ],
      )
      )
    );
      
  }
}