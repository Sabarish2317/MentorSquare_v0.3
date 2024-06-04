import 'package:flutter/material.dart';

Widget appTextLogo() {
  return const Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Mentor',
          style: TextStyle(
            color: Color(0xFF171717),
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        TextSpan(
          text: 'Square',
          style: TextStyle(
            color: Color(0xFF7D13BE),
            fontSize: 24,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    ),
    textAlign: TextAlign.center,
  );
}
