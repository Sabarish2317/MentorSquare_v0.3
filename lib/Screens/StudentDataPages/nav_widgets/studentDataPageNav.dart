import 'package:flutter/material.dart';

List<BottomNavigationBarItem> studentDPbottomNav() {
  return [
    BottomNavigationBarItem(
      label: "",
      activeIcon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/pieOn.png',
          fit: BoxFit.cover,
          color: const Color(0xff9672F8),
        ),
      ),
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/pie.png',
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
          'lib/Assets/icons/calenderOn.png',
          fit: BoxFit.cover,
          color: const Color(0xff9672F8),
        ),
      ),
      icon: SizedBox(
        height: 24,
        width: 24,
        child: Image.asset(
          'lib/Assets/icons/calender.png',
          fit: BoxFit.cover,
          color: const Color(0xff23324C),
        ),
      ),
    ),
  ];
}
