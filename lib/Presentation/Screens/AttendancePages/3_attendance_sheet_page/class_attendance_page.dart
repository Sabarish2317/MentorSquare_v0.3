import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/Presentation/LandingPage/reusable_scaffold.dart';

import 'package:mentor_square/Presentation/Screens/AttendancePages/3_attendance_sheet_page/widgets/mysf_attendance_grid.dart';
import 'package:mentor_square/Presentation/Screens/LoginPage/widgets/login_button.dart';

import '../../../../ui_consts/them_data.dart';
import '../../../../widgets/global_widgets/add_height.dart';

class MarkAttendancePage extends StatefulWidget {
  const MarkAttendancePage({super.key});

  @override
  State<MarkAttendancePage> createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return MyPublicScaffold(
        overridePadding: true,
        overrideGradientBorderRadius: true,
        height: 120.h,
        showStudentDetails: false,
        mainWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('AIML-B',
                                style: appTheme.textTheme.titleMedium
                                    ?.copyWith(fontSize: 16)),
                            Addheight(height: 3.h),
                            Text('SECOND YEAR',
                                style: appTheme.textTheme.displayLarge
                                    ?.copyWith(fontSize: 12)),
                          ]),
                    ],
                  ),
                  Addheight(height: 20.h),
                  const Text(
                    'PHYSICS OF PHOTONICS',
                    style: TextStyle(
                      color: Color(0xFF4154F1),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Addheight(
              height: 35.h,
            ),
            const MySfDataGrid(),
            const Addheight(
              height: 20,
            ),
            const Center(
                child: LoginButton(
              isLoginPage: false,
              text: "Submit",
            ))
          ],
        ));
  }
}
