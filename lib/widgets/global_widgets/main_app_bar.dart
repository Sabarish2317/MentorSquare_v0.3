import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui_consts/colors.dart';
import '../../ui_consts/icons_const.dart';
import '../bottomup_widgets/bottomUpMenu/bottom_up_menu.dart';
import 'app_logo_txt.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final bool notificationBadge;

  const MyAppBar({
    super.key,
    required this.notificationBadge,
  }) : preferredSize = const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color.fromARGB(7, 150, 114, 248),
        ),
        backgroundColor: tdBgColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment(1.00, -0.00),
            end: Alignment(-1, 0),
            colors: [
              Color.fromRGBO(251, 130, 196, 0.2),
              Color.fromRGBO(150, 114, 248, 0.2)
            ],
          )),
        ),
        title: SizedBox(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const Wrap(children: [MyBottomUpMenu()]);
                          //the widgets inside for the bottom sheet is strored in widgets>bottom_upwidgets.
                        },
                      );
                    },
                    onDoubleTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const Wrap(children: [MyBottomUpMenu()]);
                          //the widgets inside for the bottom sheet is strored in widgets>bottom_upwidgets.
                        },
                      );
                    },
                    child: InkWell(
                      child: Image.asset(
                        burgerMenu,
                        height: 24.h,
                        width: 24.w,
                      ),
                    )),
                MyAppLogo(size: 24.sp),
                Stack(children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      bellNotifi,
                      height: 20.h,
                      width: 20.h,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 2.w,
                    child: SizedBox(
                      height: 9.2.h,
                      width: 9.2.h,
                      child: notificationBadge
                          ? Image.asset(
                              dotNotifi,
                              height: 9.2.h,
                              width: 9.2.h,
                            )
                          : Image.asset(nullImg),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ));
  }
}
