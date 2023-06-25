import 'package:flutter/material.dart';

class BloodOptions extends StatelessWidget {
  final String headText;
  final Function onTap;
  final bool active;
  const BloodOptions({
    super.key,
    required this.headText,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 150 / 375,
      height: MediaQuery.of(context).size.height * 125 / 727,
      decoration: BoxDecoration(
          border: Border.all(),
          color: const Color(0xffFFE3E3),
          borderRadius: BorderRadius.circular(22)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              headText,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 17 / 727,
                  fontWeight: FontWeight.bold),
            ),
          ),
          active
              ? InkWell(
                  onTap: () => onTap(),
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    margin: const EdgeInsets.only(left: 92),
                    width: MediaQuery.of(context).size.width * 50 / 375,
                    height: MediaQuery.of(context).size.height * 37 / 727,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xffFF4040)),
                    child: const Icon(Icons.arrow_forward_rounded),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
