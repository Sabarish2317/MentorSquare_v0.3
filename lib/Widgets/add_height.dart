import 'package:flutter/material.dart';

class Addheight extends StatelessWidget {
  final double? height;
  final double? width;
  const Addheight({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
