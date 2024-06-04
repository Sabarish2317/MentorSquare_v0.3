import 'package:flutter/material.dart';

import 'package:mentor_square/Presentation/LandingPage/reusable_scaffold.dart';

import '../../widgets/navbar_widget/bottom_nav_itemns.dart';

//
//The landing page is the main Scaffold returning the to the material app in the main func() it renders all the r screens in bottom nav bar
//when inner pages are opened this scaffold is overStacked by that page"s own Scaffold

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //
  //Selected page is 0 for the homepage index in bottomnav bar
  //
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    //

    //
    return
        //
        //Public Scaffold utilizes the theme template for the ui of the app
        //
        MyPublicScaffold(
      overridePadding: false,
      showStudentDetails: true,
      overrideGradientBorderRadius: false,
      bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: selectedPage,
          backgroundColor: Colors.white,
          onTap: (index) {
            setState(() {
              selectedPage = index;
            });
          }),
      mainWidget: pageOptions[selectedPage],
    );
  }
}
