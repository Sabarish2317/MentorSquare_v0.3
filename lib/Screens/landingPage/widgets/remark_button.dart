import 'package:flutter/material.dart';

Widget remarkButton(int year) {
  late String concat;
  if (year == 1) {
    concat = "1st";
  } else if (year == 2) {
    concat = "2nd";
  } else if (year == 3) {
    concat = "3rd";
  } else if (year == 4) {
    concat = "4th";
  }
  return Container(
    constraints: const BoxConstraints(maxWidth: 120),
    height: 25,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: (75 >= 75)
          ? const Color(0x4C7CC749)
          : const Color.fromARGB(54, 255, 0, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      shadows: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 19.90,
          offset: Offset(-2, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            child: Text(
              (75 >= 75) ? "$concat year " : 'POOR',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: (75 >= 75)
                    ? Color(0xF2334149)
                    : Color.fromARGB(255, 83, 51, 51),
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ),
        const SizedBox(
          child: Center(
              child: Icon(
            Icons.sunny,
            color: (75 >= 75)
                ? Color.fromARGB(255, 61, 102, 34)
                : Color.fromARGB(255, 158, 11, 0),
            size: 12,
          )),
        )
      ],
    ),
  );
}
