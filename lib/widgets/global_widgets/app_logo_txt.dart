import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppLogo extends StatelessWidget {
  final double size;
  const MyAppLogo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Mentor',
          style: TextStyle(
            color: const Color(0xFF171717),
            fontSize: 24.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        Text(
          'Square',
          style: TextStyle(
            color: const Color(0xFF7D13BE),
            fontSize: 24.sp,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        )
      ],
    );
  }
}
