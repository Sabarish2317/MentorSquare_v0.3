import 'package:flutter/material.dart';

import '../../../Widgets/add_height.dart';

Widget appLogo() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(
        'lib/Assets/icons/app_icon.png',
        height: 72.75,
        width: 75,
      ),
      const Addheight(height: 12),
      const Text.rich(
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
      ),
    ],
  );
}
