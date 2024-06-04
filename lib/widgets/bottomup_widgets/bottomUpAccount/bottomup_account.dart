import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Data/Widget_data_variables/global_student_data.dart';
import '../../../Presentation/Screens/LoginPage/widgets/logout_button.dart';
import '../../../ui_consts/colors.dart';
import '../../../ui_consts/icons_const.dart';
import '../../../ui_consts/them_data.dart';
import '../../global_widgets/add_height.dart';
import '../../global_widgets/mydivider.dart';
import '../qr.dart';

class MyBottomUPAccounts extends StatefulWidget {
  const MyBottomUPAccounts({super.key});

  @override
  State<MyBottomUPAccounts> createState() => _MyBottomUPAccountsState();
}

class _MyBottomUPAccountsState extends State<MyBottomUPAccounts> {
  @override
  Widget build(BuildContext context) {
    return //main widget column
        Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(19.w, 37.h, 19.w, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 69.w,
                  height: 69.w,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(
                      side: BorderSide(width: 1, color: tdPurePurple),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.69.w),
                    child: Image.asset(fakepfp),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "mentorname",
                    style: appTheme.textTheme.titleLarge
                        ?.copyWith(fontSize: 22.sp),
                  ),
                  Text(
                    studentRegNo,
                    style: appTheme.textTheme.bodyMedium
                        ?.copyWith(fontSize: 12.sp),
                  )
                ],
              ),
              const LogOutButton()
            ],
          ),
        ),
        Addheight(
          height: 28.h,
        ),
        /*div*/ MyDivider(width: 393.w),
        Padding(
            padding: EdgeInsets.fromLTRB(19.w, 37.h, 19.w, 0),
            child: SizedBox(
              height: 100.h,
              width: 268.w,

              //Genetrates barcode based on the register number of the student.
              child: const MyBarcodeGen(),
            ))
      ],
    );
  }
}
