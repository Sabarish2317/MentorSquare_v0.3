import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDivider extends StatelessWidget {
  final double width;
  const MyDivider({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignCenter,
            color: Color(0xFFD0D3FC),
          ),
        ),
      ),
    );
  }
}
