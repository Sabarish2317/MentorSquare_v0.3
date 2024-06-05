import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/AccountPage/account_bottom_up.dart';
import 'package:mentor_square_v3_responsive/Screens/AccountPage/account_page.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/bloc/staff_favourites_details_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/landing_page.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/year_dept_class_selection_widget/attendance_year_bottomup.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/widgets/search_bar.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/widgets/welcome_container.dart';
import 'package:mentor_square_v3_responsive/Screens/splash%20page/splash_screen.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';

import 'package:mentor_square_v3_responsive/Widgets/app_text_logo.dart';
import 'package:mentor_square_v3_responsive/Widgets/bottom_nav_bar.dart';

import 'Details_card/details_card_tile.dart';
//this coantins types of scaffold to display in case of succes and error

Widget mainScaffold(int staffId, String name, String regNo,
    BuildContext context, Map<dynamic, dynamic> favourites) {
  StaffFavouritesDetailsBloc staffFavouritesDetailsBloc =
      StaffFavouritesDetailsBloc();
  int indexStackIndex = 0;

  //changes index if the user dont have any favourites in his db
  if (favourites.isEmpty) {
    indexStackIndex = 1;
  } else {
    List<String> studentRegNosList = favourites.values.cast<String>().toList();

    String studentRegNosString =
        studentRegNosList.join(',').replaceAll("'", "");

    staffFavouritesDetailsBloc
        .add(StaffFavouritesDetailsGetEvent(regNos: studentRegNosString));
  }

  //curremt index to keep track of the pages
  int currentIndex = 0;
  return Scaffold(
    backgroundColor: const Color(0xffECF2FF),
    bottomNavigationBar: BottomNavigationBar(
      items: bottomNavBar(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: 0,
      elevation: 25,
      backgroundColor: Colors.white,
      onTap: (value) {
        navigateTo(value, context, currentIndex, staffId);
      },
    ),
    appBar: AppBar(
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.purple,
      bottomOpacity: 0,
      toolbarOpacity: 0,
      backgroundColor: const Color(0xffECF2FF),
      centerTitle: true,
      title: appTextLogo(),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Welcome header container
              WelcomeContainer(
                staffName: name,
                staffRegNo: regNo,
                isWelcome: true,
              ),
              const Addheight(height: 18),
              MySearchBar(
                showAlert: () => alertbox("Invalid register number", context),
              ),
              const Addheight(height: 18),
              const SizedBox(
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.left,
                  'STUDENT ATTENDANCE',
                  style: TextStyle(
                    color: Color(0xFF7D13BE),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),

              //gets student favourites if existsj

              IndexedStack(index: indexStackIndex, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Addheight(height: 18),
                    BlocProvider(
                      create: (context) => staffFavouritesDetailsBloc,
                      child: BlocBuilder<StaffFavouritesDetailsBloc,
                          StaffFavouritesDetailsState>(
                        builder: (context, state) {
                          if (state
                              is StaffFavouritesDetailsFetchingSuccessState) {
                            print(
                                'Number of students: ${state.studentsDetails.length}');
                            return Builder(
                                builder: (context) => ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.studentsDetails.length,
                                      itemBuilder: (context, index) {
                                        // Debugging line
                                        return Column(
                                          children: [
                                            DetailTile(
                                              studentDetail:
                                                  state.studentsDetails[index],
                                            ),
                                            const Addheight(height: 12),
                                          ],
                                        );
                                      },
                                    ));
                          }
                          return Column(
                            children: [
                              Image.asset(
                                'lib/Assets/icons/noDataImg.jpg',
                              ),
                              const Text(
                                'Please add Students to Quick Access tile',
                                style: TextStyle(
                                  color: Color(0xFF00111C),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                    //test data
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'lib/Assets/icons/noDataImg.jpg',
                    ),
                    const Text(
                      'Please add Students to Quick Access tile',
                      style: TextStyle(
                        color: Color(0xFF00111C),
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    ),
  );
}

void navigateTo(
    int value, BuildContext context, int currentIndex, int staffId) {
  final List<Widget> pages = [
    const LandingPage(),
    const AccountsPage(),
    const AccountsPage()
  ];
  //prevents opening same page again
  if (value != currentIndex) {
    if (value == 2) {
      accountsBottomSheet(context, staffId);
    } else if (value == 1) {
      //callingn the function which pops the bottm sheet and calls the api
      modalBottomSheetMenu(context);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => pages[value]));
    }
  }
}

//error scaffold
Widget errorScaffold(BuildContext context, state) {
  //local storage delete and remove all pages from stack
  void logout() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false,
    );
  }

  return Scaffold(
    backgroundColor: const Color(0xffECF2FF),
    body: Center(
      child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Row(
          children: [
            Icon(Icons.error, color: Colors.red),
            SizedBox(width: 10),
            Text('Error'),
          ],
        ),
        content: Text(state.errorMessage),
        actions: <Widget>[
          ElevatedButton(
              style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFA788FF))),
              onPressed: () {
                logout();
              },
              child: const Text(
                'LOGOUT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: 0.32,
                ),
              ))
        ],
      ),
    ),
  );
}
