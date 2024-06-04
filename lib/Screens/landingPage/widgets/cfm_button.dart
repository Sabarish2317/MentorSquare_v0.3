import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

Widget cfmButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: const Color.fromRGBO(141, 140, 245, 0.6)),
        child: Material(
          borderRadius: BorderRadius.circular(9),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(9),
            onTap: () {},
            splashColor: const Color.fromARGB(73, 66, 64, 214),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9)),
                shadows: const [
                  BoxShadow(
                    color: Color(0x07000000),
                    blurRadius: 19.90,
                    offset: Offset(-2, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'More',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xF2334149),
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Addheight(width: 4),
                  Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
