import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class GradientStack extends StatefulWidget {
  final double height;
  final Widget child;
  final bool overridePadding;
  final bool overridegradientBorderRadius;
  const GradientStack(
      {super.key,
      required this.height,
      required this.child,
      required this.overridePadding,
      required this.overridegradientBorderRadius});

  @override
  State<GradientStack> createState() => _GradientStackState();
}

class _GradientStackState extends State<GradientStack> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: widget.height.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.00, -0.00),
              end: Alignment(-1, 0),
              colors: [
                Color.fromRGBO(251, 130, 196, 0.2),
                Color.fromRGBO(150, 114, 248, 0.2)
              ],
            ),
            borderRadius: (widget.overridePadding)
                ? null
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
          )),
      SizedBox(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.overridePadding ? 0 : 20.w),
              child: widget.child))
    ]);
  }
}
