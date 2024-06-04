import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Data/Widget_data_variables/subject_class_details.dart';
import '../../../../widgets/bottomup_widgets/bottomUpglobal/bottomup.dart';
import '../../../../ui_consts/colors.dart';
import '../../../../ui_consts/them_data.dart';
import '../../../../widgets/bottomup_widgets/bottomupYearSelection/bottomup_year.dart';
import '../../../../widgets/global_widgets/add_height.dart';
import '../../../../widgets/global_widgets/name_grid.dart';
import '../../../LandingPage/reusable_scaffold.dart';
import '../2_course_selection_page/course_class_selection_screen.dart';

class ClassSelectionPage extends StatefulWidget {
  const ClassSelectionPage({super.key});

  @override
  State<ClassSelectionPage> createState() => _ClassSelectionPageState();
}

class _ClassSelectionPageState extends State<ClassSelectionPage> {
  @override
  void initState() {
    super.initState();

    // Trigger the bottom sheet after the page is loaded
    _modalBottomSheetMenu();
  }

  void _modalBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () => Navigator.pop(context), // Close the bottom sheet
            child: const Wrap(children: [
              MyBottomUpPop(
                widget: MyBottomUpYear(),
              )
            ]),
          );
          //the widgets inside for the bottom sheet are stored in widgets>bottom_upwidgets.
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        //main screen column
        MyPublicScaffold(
            overridePadding: false,
            overrideGradientBorderRadius: false,
            showStudentDetails: true,
            mainWidget: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ATTENDANCE",
                              style: appTheme.textTheme.titleSmall?.copyWith(
                                  color: tdPureBlue,
                                  fontWeight: FontWeight.w600)),
                        ]),
                  ],
                ),
                Addheight(height: 30.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select Deparment",
                      style: appTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                NameGrid(
                    textList: departmentList,
                    navigateTo: const CourseAndClassSelectionPage())
              ],
            ));
  }
}
