import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/bloc/student_dad_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/bloc/student_details_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/bloc/student_sad_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_dad_model.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/nav_widgets/studentDataPageNav.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/widgets/student_attendance_tile.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/widgets/student_details_container.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';
import 'package:mentor_square_v3_responsive/Widgets/app_text_logo.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
  late StudentDadBloc studentDadBloc;
  late String date;
  @override
  void initState() {
    studentDetailBloc = StudentDetailsBloc();
    studentDadBloc = StudentDadBloc();
    studentDetailBloc
        .add(SearchButtonPresseddEvent(studentRegNo: (widget.studentRegNo)));
    final now = DateTime.now();
    final formatter = DateFormat('dd-MM-yyyy');
    date = formatter.format(now);
    studentSadBloc = StudentSadBloc();
    super.initState();
  }

  @override
  void dispose() {
    studentDetailBloc.close();
    studentSadBloc.close();
    super.dispose();
  }

  int dropdownValue = 1;
  int selectedWidget = 0;
  //maintanis the icons of bottom bar
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: studentDPbottomNav(),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        elevation: 25,
        backgroundColor: Colors.white,
        onTap: (value) {
          setState(() {
            if (selectedWidget != value) {
              selectedWidget = value;
              currentIndex = value;
              if (value == 1) {}
            }
          });
        },
      ),
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
        child: SingleChildScrollView(
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
                      //how to make this event not add again when the setstate above rebuild the page
                      if (!studentSadBloc.isClosed) {
                        studentSadBloc.add(StudentSADfetchEvent(dropdownValue,
                            studentDetail: state.resultData));
                      } else {
                        alertbox("Error occured Try again", context);
                      }
                      if (!studentDadBloc.isClosed) {
                        studentDadBloc.add(StudentDadFetchEvent(
                            semNo: dropdownValue.toString(),
                            studentId:
                                state.resultData.studentIdDt.toString()));
                      }
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
                                        width: 0.20, color: Color(0xFF8D8CF5)),
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
                                  items: [1, 2, 3, 4, 5, 6, 7, 8]
                                      .map<DropdownMenuItem<int>>((int value) {
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
              //indexed stack to switch between the subject attendannce and daiky attendance
              Center(
                child: IndexedStack(index: selectedWidget, children: [
                  //subject attendance
                  Visibility(
                    visible: (selectedWidget == 0) ? true : false,
                    child: BlocProvider(
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
                    ),
                  ),
                  //studnet date attendance provider
                  Visibility(
                    visible: (selectedWidget == 1) ? true : false,
                    child: BlocProvider(
                      create: (context) => studentDadBloc,
                      child: BlocBuilder<StudentDadBloc, StudentDadState>(
                        builder: (context, state) {
                          if (state is StudentDadLoadingState) {
                            return const CircularProgressIndicator();
                          } else if (state is StudentDadErrorState) {
                            return alertbox(state.errorMessage, context);
                          } else if (state is StudentDaduccessState) {
                            StudentDataSource studentAttendanceDataSource =
                                StudentDataSource(
                                    studentAttendanceData: state.resultData);
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: ClipRect(
                                clipper: CustomLeftClipper(),
                                child: SfDataGridTheme(
                                  data: const SfDataGridThemeData(
                                      headerHoverColor: Colors.white,
                                      headerColor:
                                          Color.fromARGB(131, 150, 114, 248),
                                      frozenPaneElevation: 10,
                                      frozenPaneLineWidth: 0.5,
                                      frozenPaneLineColor: Colors.transparent),
                                  child: SfDataGrid(
                                    showVerticalScrollbar: true,
                                    gridLinesVisibility:
                                        GridLinesVisibility.horizontal,
                                    frozenColumnsCount: 1,
                                    horizontalScrollController:
                                        ScrollController(),
                                    source: studentAttendanceDataSource,
                                    columnWidthMode:
                                        ColumnWidthMode.fitByColumnName,
                                    columns: <GridColumn>[
                                      GridColumn(
                                          allowFiltering: false,
                                          width: 70,
                                          columnName: 'S.no',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'S.NO',
                                              ))),
                                      GridColumn(
                                          columnName: 'Date',
                                          width: 90,
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Date',
                                              ))),
                                      GridColumn(
                                          width: 78,
                                          columnName: 'Day',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text('Day'))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P1',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '1',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P2',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '2',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P3',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '3',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P4',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '4',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P5',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '5',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P6',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '6',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P7',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '7',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                      GridColumn(
                                          width: 75,
                                          columnName: 'P8',
                                          label: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '8',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
//model for student data grid table

class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<Attendance> studentAttendanceData}) {
    //dummy data to provide if it is null
    Map<String, dynamic> nullData = {'-': 'null'};
    MapEntry<String, dynamic> nullVal = nullData.entries.first;
    _studentAttendanceData =
        List<DataGridRow>.generate(studentAttendanceData.length, (index) {
      final student = studentAttendanceData[index];
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'S.no', value: index + 1),
        DataGridCell<String>(
            columnName: 'Date', value: student.date.toString()),
        DataGridCell<String>(
            columnName: 'Day', value: dayIdtoDay(student.dayId)),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P1',
            value: student.period1Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P2',
            value: student.period2Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P3',
            value: student.period3Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P4',
            value: student.period4Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P5',
            value: student.period5Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P6',
            value: student.period6Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P7',
            value: student.period7Status?.entries.first ?? nullVal),
        DataGridCell<MapEntry<String, dynamic>?>(
            columnName: 'P8',
            value: student.period8Status?.entries.first ?? nullVal),
      ]);
    });
  }

  List<DataGridRow> _studentAttendanceData = [];

  @override
  List<DataGridRow> get rows => _studentAttendanceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.columnName == 'S.no' ||
          e.columnName == 'Date' ||
          e.columnName == 'Day') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.value.toString(),
            style: const TextStyle(
              color: Color(0xFF344054),
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        );
      } else {
        final periodStatus = e.value as MapEntry<String, dynamic>;
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            periodStatus.key.toString(),
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
              color: (periodStatus.value == 'true' ||
                      periodStatus.value == true ||
                      periodStatus.value == 'True')
                  ? Colors.green
                  : (periodStatus.value == 'null')
                      ? Colors.grey
                      : Colors.red,
            ),
          ),
        );
      }
    }).toList());
  }
}

String dayIdtoDay(int dayId) {
  switch (dayId) {
    case 1:
      return "Mon";
    case 2:
      return "Tue";
    case 3:
      return "Wed";
    case 4:
      return "Thu";
    case 5:
      return "Fri";
    case 6:
      return "Sat";
    default:
      return "Sun";
  }
}

//custom rect clup by sf

class CustomLeftClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height - 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
