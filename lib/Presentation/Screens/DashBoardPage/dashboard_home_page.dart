// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/Features/StaffDetail/Bloc/bloc/staff_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Widget_data_variables/global_student_data.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/my_expansiontil.dart';
import '../../../widgets/global_widgets/add_height.dart';
import '../../../ui_consts/colors.dart';
import '../../../ui_consts/icons_const.dart';
import '../../../ui_consts/them_data.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final StaffDetailsBloc staffDetailBloc = StaffDetailsBloc();

  @override
  Widget build(BuildContext context) {
    //Main page column

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      /*Cards box& column*/ SizedBox(
          width: 352.w,
          height: 216.h,
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*card 1 & card2*/ Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DashboardCard(
                        endColor: tdGreen,
                        header1: 'Attendance',
                        header2: 'Manager',
                        body1: 'Overall',
                        icon: atteManager),
                    DashboardCard(
                        endColor: tdRed,
                        header1: 'Marks',
                        header2: 'Manager',
                        body1: 'Semester-1',
                        icon: marksManager),
                  ],
                ),
                /*card 3 & card4*/ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashboardCard(
                          endColor: tdOrange,
                          header1: 'Events',
                          header2: 'Manager',
                          body1: 'SNSCT',
                          icon: eventsManager),
                      DashboardCard(
                          endColor: tdPureBlue,
                          header1: 'Task',
                          header2: 'Manager',
                          body1: 'SNSCT',
                          icon: taskManager),
                    ])
              ])),
      const Addheight(height: 32),
      //Title Header
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Addheight(width: 2),
        Text(
          "CURRENT TASKS",
          style: appTheme.textTheme.titleLarge?.copyWith(fontSize: 20.sp),
        )
      ]),

      /*Expansion tile task view is present inside this custom MyExptile 
              */
      //refer data/dashdatapage for variables used below
      MyExpTile(
        titleText: titleTextData,
        subtitleText: subtitleTextData,
        descriptiveText: descriptiveTextData,
      )
    ]);
  }
}
