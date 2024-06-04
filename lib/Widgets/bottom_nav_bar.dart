import 'package:flutter/material.dart';

List<BottomNavigationBarItem> bottomNavBar() {
  return [
    BottomNavigationBarItem(
      label: "",
      activeIcon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/homeOn.png',
          fit: BoxFit.cover,
          color: const Color(0xff9672F8),
        ),
      ),
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/home.png',
          fit: BoxFit.cover,
          color: const Color(0xff23324C),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: "",
      activeIcon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/attendance.png',
          fit: BoxFit.cover,
          color: const Color(0xff9672F8),
        ),
      ),
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/attendance.png',
          fit: BoxFit.cover,
          color: const Color(0xff23324C),
        ),
      ),
    ),
    BottomNavigationBarItem(
      label: "",
      activeIcon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/profileOn.png',
          fit: BoxFit.cover,
          color: const Color(0xff9672F8),
        ),
      ),
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/profile.png',
          fit: BoxFit.cover,
          color: const Color(0xff23324C),
        ),
      ),
    ),
  ];
}
