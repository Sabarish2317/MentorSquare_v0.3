import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bottomUpAccount/bottomup_account.dart';
import 'bottomup.dart';

class MyAccount extends StatefulWidget {
  final String myicon;
  const MyAccount({super.key, required this.myicon});

  @override
  State<MyAccount> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //gesture detector layers on top of the icon and detects touch input and calls bottomSheet based on the type of the input
        onLongPress: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const Wrap(children: [
                //Mybottom up is uiSkelton of the custom bottomupSheet
                MyBottomUp(
                  //mybottomUPaccounts has shows ui info about student and his barcode
                  widget: MyBottomUPAccounts(),
                )
              ]);
            },
          );
        },
        onDoubleTap: () {
          showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const Wrap(children: [
                MyBottomUp(
                  widget: MyBottomUPAccounts(),
                )
              ]);
            },
          );
        },
        child: InkWell(
          child: Image.asset(
            widget.myicon,
            height: 24.h,
            width: 24.w,
          ),
        ));
  }
}
