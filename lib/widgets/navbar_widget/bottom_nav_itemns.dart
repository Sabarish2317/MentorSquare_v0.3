import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Presentation/Screens/DashBoardPage/dashboard_home_page.dart';
import '../../Presentation/Screens/FutureScreens/leaverequestpage.dart';
import '../../ui_consts/icons_const.dart';
import '../bottomup_widgets/bottomUpglobal/bottomsheet_button.dart';

List<BottomNavigationBarItem> bottomNavItems = <BottomNavigationBarItem>[
//List of items visually at bottom nav bar
  BottomNavigationBarItem(
      activeIcon: Image.asset(
        navHome,
        height: 24.h,
        width: 24.w,
      ),
      icon: Image.asset(
        navHomeout,
        height: 24.h,
        width: 24.w,
      ),
      label: 'Home'),
  BottomNavigationBarItem(
      activeIcon: Image.asset(
        navLeave,
        height: 24.h,
        width: 24.w,
      ),
      icon: Image.asset(
        navLeaveOUt,
        height: 24.h,
        width: 24.w,
      ),
      label: 'Login'),
  BottomNavigationBarItem(
      activeIcon: Image.asset(
        navPie,
        height: 24.h,
        width: 24.w,
      ),
      icon: Image.asset(
        navPieOut,
        height: 24.h,
        width: 24.w,
      ),
      label: 'Login'),
  const BottomNavigationBarItem(
      activeIcon: MyAccount(myicon: navProfile),
      icon: MyAccount(myicon: navProfileOut),
      label: 'Login'),
];

//using bloc : the parent scaffold is this landing page
//Other pages are considered as stWidgets and are rendered inside this common scaffold

//StWidgts which are child screens
final pageOptions = [
  const DashboardHome(),
  const LeaveRequestPage(),
  const PiechartPage(),
  const ProfilePage(),
];
