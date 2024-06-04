import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mentor_square/Data/Widget_data_variables/global_student_data.dart';
import 'package:mentor_square/widgets/global_widgets/add_height.dart';
import 'package:mentor_square/widgets/global_widgets/dropdownbar.dart';
import 'package:mentor_square/Presentation/LandingPage/reusable_scaffold.dart';
import 'package:mentor_square/Presentation/Screens/AttendancePages/2_course_selection_page/widgets/date_sliding_selector/date_selector.dart';
import 'package:mentor_square/Presentation/Screens/AttendancePages/2_course_selection_page/widgets/my_tile.dart';
import 'package:mentor_square/Presentation/Screens/AttendancePages/3_attendance_sheet_page/class_attendance_page.dart';
import 'package:mentor_square/ui_consts/them_data.dart';
import '../../../../ui_consts/icons_const.dart';

class CourseAndClassSelectionPage extends StatefulWidget {
  const CourseAndClassSelectionPage({super.key});

  @override
  State<CourseAndClassSelectionPage> createState() =>
      _CourseAndClassSelectionPageState();
}

class _CourseAndClassSelectionPageState
    extends State<CourseAndClassSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return MyPublicScaffold(
        overrideGradientBorderRadius: false,
        overridePadding: true,
        height: 120.h,
        showStudentDetails: false,
        mainWidget: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            //
            /*Text and Date button row   The ,onth selected is sent as a parameter into sf the linear date slider for changing the date*/
            //
            //
            Padding(
              //
              /*Seperate padding is given to ensure that the data slider compltetely covers the entire width of the screen*/
              //

              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('AIML-B',
                            style: appTheme.textTheme.titleMedium
                                ?.copyWith(fontSize: 14)),
                        Addheight(height: 3.h),
                        Text('SECOND YEAR',
                            style: appTheme.textTheme.displayLarge
                                ?.copyWith(fontSize: 12)),
                      ]),
                  MyDropDownButton(
                      initialText: getMonth(),
                      list: monthList,
                      icon: Image.asset(
                        downArrow,
                        height: 8.h,
                        color: const Color(0xff8D8CF5),
                      ))
                ],
              ),
            ),
            Addheight(height: 18.h),
            //
            //
            /*Custom DateSlider*/
            //
            //
            const MyDateSlider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Addheight(height: 32.h),
                  Text('Select Course',
                      style: appTheme.textTheme.titleMedium
                          ?.copyWith(fontSize: 16.sp)),
                  Addheight(height: 14.h),
                  const MyTile(
                    navigateTo: MarkAttendancePage(),
                    titleText: "19PHB103",
                    subtitleText: "PHYSICS OF PHOTONICS",
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

//
//
/*Fetches the current month using defualt flutter date api*/
//
//
String getMonth() {
  DateTime now = DateTime.now();
  String currentMonth = DateFormat('MMM').format(now).toUpperCase();
  return currentMonth;
}
