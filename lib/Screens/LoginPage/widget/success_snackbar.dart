import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

void showSuccessSnackbar(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 20.30,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.2,
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color.fromARGB(227, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 20.30,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 25,
                  width: 25,
                  child: Image.asset(
                    'lib/Assets/icons/successArrow.png',
                  ),
                ),
                const Addheight(width: 20),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        'Login Successful !',
                        style: TextStyle(
                          color: Color(0xFF00111C),
                          fontSize: 15,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.30,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
