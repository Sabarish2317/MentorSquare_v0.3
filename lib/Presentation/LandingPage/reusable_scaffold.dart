// ignore_for_file: type_literal_in_constant_pattern

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Features/StaffDetail/Bloc/bloc/staff_detail_bloc.dart';
import '../../ui_consts/them_data.dart';
import '../../widgets/global_widgets/add_height.dart';
import '../../widgets/global_widgets/gradient_stack.dart';
import '../../widgets/global_widgets/main_app_bar.dart';

class MyPublicScaffold extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final bottomNavigationBar;
  // ignore: prefer_typing_uninitialized_variables
  final mainWidget;
  final bool showStudentDetails;
  final double? height;
  final bool overridePadding;
  final bool overrideGradientBorderRadius;
  const MyPublicScaffold(
      {super.key,
      this.bottomNavigationBar,
      this.mainWidget,
      required this.showStudentDetails,
      this.height,
      required this.overridePadding,
      required this.overrideGradientBorderRadius});

  @override
  State<MyPublicScaffold> createState() => _MyPublicScaffoldState();
}

class _MyPublicScaffoldState extends State<MyPublicScaffold> {
  final StaffDetailsBloc staffDetailBloc = StaffDetailsBloc();
  @override
  void initState() {
    staffDetailBloc.add(StaffDetailInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            home: Scaffold(
                //app bar must hide during login page
                appBar: const MyAppBar(
                  notificationBadge: false,
                ),
                bottomNavigationBar: widget.bottomNavigationBar,
                extendBodyBehindAppBar: false,
                body: SafeArea(
                  /*Main column*/ child: SingleChildScrollView(
                    child: Column(children: [
                      //ui design component for gradient stack.
                      GradientStack(
                          height: widget.height ?? 135.0.h,
                          overridePadding: widget.overridePadding,
                          overridegradientBorderRadius:
                              widget.overrideGradientBorderRadius,
                          child: Center(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Visibility(
                                    visible: widget.showStudentDetails,
                                    replacement: Addheight(height: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Addheight(height: 18.h),
                                        Text('Mentor_Name',
                                            style: appTheme.textTheme.titleLarge
                                                ?.copyWith(
                                              fontSize: 32,
                                            )),
                                        Addheight(height: 6.h),
                                        Text('713522AM081',
                                            style: appTheme
                                                .textTheme.displayLarge
                                                ?.copyWith(
                                              fontSize: 12,
                                            )),
                                        Addheight(height: 18.h),
                                      ],
                                    ),
                                  ),
                                ),
                                //till these everything is common for every page
                                //displays screen class at presses tab index
                                widget.mainWidget
                              ],
                            ),
                          )
                          //endpoint
                          ),
                    ]),
                  ),
                ))));
    // Placeholder widget, replace with actual widget
  }
}
