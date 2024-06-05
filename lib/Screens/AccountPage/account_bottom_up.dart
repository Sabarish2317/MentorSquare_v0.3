import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/AccountPage/bloc/aff_favs_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/bloc/staff_detail_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/widgets/welcome_container.dart';
import 'package:mentor_square_v3_responsive/Screens/splash%20page/splash_screen.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';

//trigger
void accountsBottomSheet(BuildContext context, int staffId) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return AccountsBottomUp(
        staffId: staffId,
      );
    },
  );
}

class AccountsBottomUp extends StatefulWidget {
  final int staffId;
  const AccountsBottomUp({super.key, required this.staffId});

  @override
  State<AccountsBottomUp> createState() => _AccountsBottomUpState();
}

class _AccountsBottomUpState extends State<AccountsBottomUp> {
  //bloc instance
  late final StaffDetailBloc staffDetailBloc;
  late final TextEditingController favTextController;
  late final AffFavsBloc affFavsBloc;

  //fetch data on load of the scaffold
  @override
  void initState() {
    super.initState();
    affFavsBloc = AffFavsBloc();
    staffDetailBloc = StaffDetailBloc();
    staffDetailBloc.add(InitalFetchEvent(staffId: widget.staffId));
    favTextController = TextEditingController();
  }

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

  Map<String, String> convertToMap(String input) {
    List<String> elements = input.split(",");
    Map<String, String> resultMap = {};

    for (int i = 0; i < elements.length; i++) {
      resultMap["${i + 1}"] = elements[i];
    }

    return resultMap;
  }

  int widgetIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: SizedBox(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: 392,
                // height: MediaQuery.of(context).size.height / 3,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0x4C8D8CF5),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                //empty inkwell to prevent widget pop if tapped inside the container
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Addheight(height: 10),
                      /*DEOCR*/ Container(
                        width: 59,
                        height: 5,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF9672F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      /*ui decorations are over place the widget you want to show in this column */
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: BlocProvider(
                          create: (_) => staffDetailBloc,
                          child:
                              BlocConsumer<StaffDetailBloc, StaffDetailState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is StaffDetailFetchingSuccessState) {
                                return IndexedStack(
                                    index: widgetIndex,
                                    children: [
                                      Visibility(
                                        visible:
                                            (widgetIndex == 0) ? true : false,
                                        child: Column(
                                          children: [
                                            WelcomeContainer(
                                                isWelcome: false,
                                                staffName:
                                                    state.staffData.staffName ??
                                                        "",
                                                staffRegNo: state
                                                        .staffData.staffRegNo ??
                                                    ""),
                                            const Addheight(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Mail id',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF00111C),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    Text(
                                                      state.staffData.mailId,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF4154F1),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            const Addheight(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Phone NO',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF00111C),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    Text(
                                                      "+91 ${state.staffData.staffPhoneNo}",
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF4154F1),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            const Addheight(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Quick Access',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF00111C),
                                                        fontSize: 14,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          widgetIndex = 1;
                                                        });
                                                      },
                                                      child: const Text(
                                                        "TAP TO EDIT",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF4154F1),
                                                          fontSize: 14,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            const Addheight(height: 16),
                                            ElevatedButton(
                                                style: const ButtonStyle(
                                                    shape: WidgetStatePropertyAll(
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15)))),
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Color(0xFFA788FF))),
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
                                      Visibility(
                                        visible:
                                            (widgetIndex == 1) ? true : false,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            TextField(
                                              controller: favTextController,
                                              decoration: const InputDecoration(
                                                  labelText:
                                                      'Enter the Register numbers seperated by commas',
                                                  hintText:
                                                      'Eg: 713522AM081,713522AM092'),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  String text =
                                                      favTextController.text;

                                                  text = text
                                                      .replaceAll(' ', '')
                                                      .toUpperCase();
                                                  favTextController.clear;

                                                  Map<String, String>
                                                      convertedEvent =
                                                      convertToMap(text);

                                                  if (favTextController
                                                          .text.length >=
                                                      0) {
                                                    affFavsBloc.add(
                                                        AffFavsFetchEvent(
                                                            staffId: state
                                                                .staffData
                                                                .staffIdDt
                                                                .toString(),
                                                            favourites:
                                                                convertedEvent));
                                                    setState(() {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const SplashScreen()),
                                                        (route) => false,
                                                      );
                                                    });
                                                  }
                                                  BlocProvider(
                                                      create: (context) =>
                                                          affFavsBloc,
                                                      child: BlocBuilder<
                                                          AffFavsBloc,
                                                          AffFavsState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is AffFavsFetchingLoadingState) {
                                                            return const CircularProgressIndicator();
                                                          } else if (state
                                                              is AffFavsDetailFetchingSuccessState) {
                                                            Navigator.pop(
                                                                context);
                                                            // Show a success Snackbar
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      'Favorites updated successfully'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2), // Adjust duration as needed
                                                                ),
                                                              );
                                                            });
                                                            return const SizedBox
                                                                .shrink(); // Return an empty widget
                                                          } else if (state
                                                              is AffFavsFetchingErrorState) {
                                                            // Show an error Snackbar
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback(
                                                                    (_) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      'Error updating favorites. Please try again later.'),
                                                                  duration: Duration(
                                                                      seconds:
                                                                          2), // Adjust duration as needed
                                                                ),
                                                              );
                                                            });
                                                            return const SizedBox
                                                                .shrink(); // Return an empty widget
                                                          }
                                                          return const CircularProgressIndicator();
                                                        },
                                                      ));
                                                },
                                                child: const Text("ok")),
                                            Addheight(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  2,
                                            )
                                          ],
                                        ),
                                      )
                                    ]);
                              } else if (state
                                  is StaffDetailFetchingErrorState) {
                                alertbox(state.errorMessage, context);
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
