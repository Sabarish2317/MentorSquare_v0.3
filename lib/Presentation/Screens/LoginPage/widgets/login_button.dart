import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../LandingPage/landing_page_main.dart';
import '../../../../ui_consts/colors.dart';
import '../../../../ui_consts/them_data.dart';

class LoginButton extends StatefulWidget {
  //bool to use this button both in login oage and other parts of the app
  final bool isLoginPage;
  final String text;
  const LoginButton({super.key, required this.text, required this.isLoginPage});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  _login(BuildContext context) async {
    if (widget.isLoginPage == true) {
      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
        (route) => false,
      );
    } else {
      // Create a Completer

      return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingPage(),
        ),
        (route) => false,
      ).then((value) => Future.delayed(Duration(milliseconds: 500))
          .then((value) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attendance added successfully')),
              )));

      // After navigation completes, show the SnackBar
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _login(context),
      child: Container(
        width: 289.w,
        height: 44.h,
        decoration: ShapeDecoration(
          color: tdPurePurple,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.50,
              color: Colors.white.withOpacity(0.15),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 5,
              offset: Offset(0, 4),
              spreadRadius: 1,
            )
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: appTheme.textTheme.titleMedium?.copyWith(
              color: tdBgColor,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
