import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

ThemeData appTheme = ThemeData(
    //text and bnb theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 100,
        backgroundColor: tdgray,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    scaffoldBackgroundColor: tdBgColor,
    /*Text themes*/ textTheme: TextTheme(
      titleLarge: TextStyle(
        color: const Color(0xFF012970),
        fontSize: 32.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0.16.sp,
      ),
      titleMedium: TextStyle(
        color: const Color(0xFF00111C),
        fontSize: 16.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      titleSmall: TextStyle(
        color: const Color(0xFF474B51),
        fontSize: 13.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
      labelLarge: TextStyle(
        color: const Color(0xFF9672F8),
        fontSize: 12.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w800,
        height: 0,
      ),
      labelMedium: TextStyle(
        color: const Color(0xFF4154F1),
        fontSize: 12.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 0,
        letterSpacing: 0.24.sp,
      ),
      labelSmall: TextStyle(
        color: const Color(0xFF344054),
        fontSize: 12.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w500,
        height: 0,
      ),
      displayLarge: TextStyle(
        color: const Color(0xFF00111C),
        fontSize: 12.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      displayMedium: TextStyle(
        color: const Color(0xFF344054),
        fontSize: 12.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      bodyLarge: TextStyle(
        color: const Color(0xFF334149),
        fontSize: 10.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      helperStyle: TextStyle(
        color: const Color(0xFF6B6B6B),
        fontSize: 13.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      hintStyle: TextStyle(
        color: const Color(0xFF6B6B6B),
        fontSize: 13.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        height: 0,
      ),
      labelStyle: TextStyle(
        color: const Color(0xFF474B51),
        fontSize: 13.sp,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 0,
      ),
    ));
