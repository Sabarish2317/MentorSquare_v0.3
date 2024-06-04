import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/bloc/student_details_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/bloc/student_sad_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/widgets/student_attendance_tile.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/widgets/student_details_container.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';
import 'package:mentor_square_v3_responsive/Widgets/app_text_logo.dart';

class StudentDetailPage extends StatefulWidget {
  final String studentRegNo;

  const StudentDetailPage({super.key, required this.studentRegNo});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  //first nbloc
  late StudentDetailsBloc studentDetailBloc;
  //this bloc gets data and initialises the secnd bloc till that it is loadingn
  late StudentSadBloc studentSadBloc;
  late String date;
  @override
  void initState() {
    studentDetailBloc = StudentDetailsBloc();
    studentDetailBloc
        .add(SearchButtonPresseddEvent(studentRegNo: (widget.studentRegNo)));
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    date = formatter.format(now);
    studentSadBloc = StudentSadBloc();
    super.initState();
  }

  int dropdownValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffECF2FF),
        appBar: AppBar(
          scrolledUnderElevation: 1,
          surfaceTintColor: Colors.purple,
          bottomOpacity: 0,
          toolbarOpacity: 0,
          backgroundColor: const Color(0xffECF2FF),
          centerTitle: true,
          title: appTextLogo(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Addheight(height: 18),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'STUDENT ATTENDANCE',
                      style: TextStyle(
                        color: Color(0xFF7D13BE),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const Addheight(height: 18),
                BlocProvider(
                  create: (context) => studentDetailBloc,
                  child: BlocBuilder<StudentDetailsBloc, StudentDetailsState>(
                    builder: (context, state) {
                      if (state is StudentDetailsLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is StudentDetailErrorState) {
                        return alertbox(state.errorMessage, context);
                      } else if (state is StudentDetailSuccessState) {
                        studentSadBloc.add(StudentSADfetchEvent(dropdownValue,
                            studentDetail: state.resultData));
                        //dont mind these nonsense skip 10 lines
                        String concat;
                        if (state.resultData.yearName == 1) {
                          concat = 'I';
                        } else if (state.resultData.yearName == 2) {
                          concat = 'II';
                        } else if (state.resultData.yearName == 3) {
                          concat = 'III';
                        } else {
                          concat = 'IV';
                        }

                        return Column(
                          children: [
                            StudentDetailsContainer(
                              date: date,
                              registerNo: state.resultData.studentRegNo,
                              studentName: state.resultData.studentName,
                            ),
                            const Addheight(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      state.resultData.className,
                                      style: const TextStyle(
                                        color: Color(0xFF00111C),
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const Addheight(height: 3),
                                    Text(
                                      '$concat YEAR',
                                      style: const TextStyle(
                                        color: Color(0xFF344054),
                                        fontSize: 12,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: 125,
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: Colors.white
                                        .withOpacity(0.800000011920929),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.20,
                                          color: Color(0xFF8D8CF5)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x0C000000),
                                        blurRadius: 20,
                                        offset: Offset(0, 0),
                                        spreadRadius: 2,
                                      )
                                    ],
                                  ),
                                  child: DropdownButton<int>(
                                    dropdownColor: const Color(0xffffffff),
                                    isExpanded: true,
                                    borderRadius: BorderRadius.circular(10),
                                    elevation: 1,
                                    alignment: AlignmentDirectional.centerStart,
                                    value: dropdownValue,
                                    icon: const Icon(
                                      Icons.arrow_drop_down_rounded,
                                      color: Color(0xff334149),
                                    ),
                                    iconSize: 24,
                                    style: const TextStyle(
                                      color: Color(0xFF344054),
                                      fontSize: 13,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                    underline: const SizedBox(),
                                    onChanged: (value) {
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: [
                                      1,
                                      2,
                                      3,
                                      4,
                                      5,
                                      6,
                                      7,
                                      8
                                    ].map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                            "Semester-$value"), // Convert int to string for display
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                const Addheight(height: 18),
                BlocProvider(
                  create: (context) => studentSadBloc,
                  child: BlocBuilder<StudentSadBloc, StudentSadState>(
                    builder: (context, state) {
                      if (state is StudentSadLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is StudentSadErrorState) {
                        return alertbox(state.errorMessage, context);
                      } else if (state is StudentSadSuccessState) {
                        return Builder(
                            builder: (context) => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.resultData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return sadTile(state.resultData[index]);
                                  },
                                ));
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
