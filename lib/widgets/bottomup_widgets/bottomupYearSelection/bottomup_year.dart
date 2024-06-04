import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/widgets/global_widgets/add_height.dart';
import 'package:mentor_square/widgets/global_widgets/name_grid.dart';

import '../../../Presentation/Screens/AttendancePages/2_course_selection_page/course_class_selection_screen.dart';
import '../../../ui_consts/them_data.dart';

class MyBottomUpYear extends StatefulWidget {
  const MyBottomUpYear({super.key});

  @override
  State<MyBottomUpYear> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyBottomUpYear> {
  @override
  Widget build(BuildContext context) {
    return Column(
      //goes inside the bottomup skeleton function
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text("Select Class Year",
              style: appTheme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20.sp)),
        ),
        Addheight(
          height: 15.h,
        ),
//refer isndie NameGrid class for further details.
        const NameGrid(
          textList: [
            "I-Year",
            "II-Year",
            "III-Year",
            "IV-Year",
          ],
          navigateTo: CourseAndClassSelectionPage(),
        ),
      ],
    );
  }
}
