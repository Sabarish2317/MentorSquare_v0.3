import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

class MyBottomUp extends StatefulWidget {
  final Widget widget;
  const MyBottomUp({super.key, required this.widget});

  @override
  State<MyBottomUp> createState() => _MyBottomUpState();
}

class _MyBottomUpState extends State<MyBottomUp> {
  @override
  Widget build(BuildContext context) {
    //used a inkwell to wrap it so touiching anything wll pop it off wll impleent later when using backends

    //this is a custom bottomUp sheet it uses container and column to nest its widgets. Stack is used to bring the sheet on top of the current page the user is on.
    return InkWell(
      child: SizedBox(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: 392,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0x4C8D8CF5),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    const Addheight(height: 10),
                    /*DEOCR*/ Container(
                      width: 59,
                      height: 5,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF9672F8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    /*ui decorations are over place the widget you want to show in this column */
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: widget.widget,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
