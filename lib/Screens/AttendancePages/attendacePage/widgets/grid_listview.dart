import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/bloc/save_attendance_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/model/students_list.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/widgets/grid_header.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/widgets/grid_row_tile.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/landing_page.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';

class GridListview extends StatefulWidget {
  final List<StudentsList> studentsData;
  final SaveAttendanceBloc saveAttendacenBloc;
  final ScheduleModel subjectData;
  final int selectedYearId;
  final int selectedClassId;
  final int selectedDeptId;
  final String selectedYearName;
  final String selectedClassName;
  final String selectedDeptName;
  final String currentDate;
  final int currentDayId;
  final int currentPeriod;

  const GridListview(
      {super.key,
      required this.studentsData,
      required this.saveAttendacenBloc,
      required this.subjectData,
      required this.selectedYearId,
      required this.selectedClassId,
      required this.selectedDeptId,
      required this.selectedYearName,
      required this.selectedClassName,
      required this.selectedDeptName,
      required this.currentDate,
      required this.currentDayId,
      required this.currentPeriod});

  @override
  State<GridListview> createState() => _GridListviewState();
}

class _GridListviewState extends State<GridListview> {
//
//This a temporary insatance of the studentData all edits are performed on this data rather than the parent data ,thus this data can be exported
//
  late List<StudentsList> editableStudentData;
  late SaveAttendanceBloc saveAttendanceBloc;
  int? staffId;
  String? tkn;

  Future<void> _loadStaffId() async {
    int? id = await getStaffIdFromSS();
    String? tknn = await getTkn();
    setState(() {
      staffId = id;
      tkn = tknn;
    });
  }
  //
  //local storage retrival

  Future<int?> getStaffIdFromSS() async {
    const storage = FlutterSecureStorage();
    String? staffd = await storage.read(key: 'staffId');
    print("attendance marked by staff: $staffd");
    return staffd != null ? int.tryParse(staffd) : null;
  }

  Future<String?> getTkn() async {
    const storage = FlutterSecureStorage();
    String? tkn = await storage.read(key: 'tkn');

    return tkn;
  }

  @override
  void initState() {
    editableStudentData = widget.studentsData;
    saveAttendanceBloc = widget.saveAttendacenBloc;
    getStaffIdFromSS();
    _loadStaffId();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//@functions

//this function is used in the header to change the overall data as true or false
    void changeAllBool(bool newValue) {
      for (int i = 0; i < editableStudentData.length; i++) {
        setState(() {
          editableStudentData[i].bool = newValue;
        });
      }
      // print("edited data : ${editableStudentData[0].bool}");
    }

//this function is used in the header to change the overall data as true or false
    void changeBool(int index, bool newValue) {
      setState(() {
        editableStudentData[index].bool = newValue;
      });
      // print("edited data : ${editableStudentData[index].bool}");
    }
//function to get the auth token and the staff id to pass it into the bloc

    return BlocProvider(
      create: (context) => saveAttendanceBloc,
      child: BlocListener<SaveAttendanceBloc, SaveAttendanceState>(
        listener: (context, state) {
          if (state is SaveAttendanceErrorState) {
            alertbox(state.errorMessage, context);
          } else if (state is SaveAttendanceSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LandingPage()),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: Colors.green,
                content: Text(state.responseData),
                duration: const Duration(seconds: 10),
              ),
            );
          }
        },
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                gridHeader(context, (newValue) => changeAllBool(newValue)),
                Container(
                  color: Colors.white,
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: editableStudentData.length,
                      itemBuilder: (context, index) {
                        StudentsList currentData = editableStudentData[index];
                        return GridRowTile(
                            regNo: currentData.studentRegNo,
                            studentName: currentData.studentName,
                            attStatus: currentData.bool,
                            onPressed: (value) => changeBool(index, value));
                      }),
                ),
                const Divider(
                  height: 1,
                  color: Color(0xFFB0B4EB),
                ),
                const Addheight(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired radius here
                              ),
                            ),
                            elevation: const WidgetStatePropertyAll(0),
                            backgroundColor: const WidgetStatePropertyAll(
                                Color(0xE59672F8))),
                        onPressed: () {
                          List<Map<String, dynamic>> attStatus = [];
                          print('Attendance Submit button pressed');
                          for (int i = 0; i < editableStudentData.length; i++) {
                            StudentsList curntData = editableStudentData[i];
                            attStatus.add(
                              {
                                "studentid": curntData.studentIdDt.toString(),
                                "attstatus": curntData.bool
                              },
                            );
                          }
                          print('remove this during prodcutin');
                          saveAttendanceBloc.add(SaveAttendanceButtonPresses(
                            attStatus: attStatus,
                            //this sem number is actually year id the process is done in background to convert year id into sem no based on the insitituitions periodd
                            semNo: widget.selectedYearId,
                            auth: tkn ??
                                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTQ1MDY5NTN9.ZBsVhN4g-yJxv42bLLInlgCHoirWIMH1I-B-pyTlKiE',
                            date: widget.currentDate,
                            day: widget.currentDayId,
                            periodNo: widget.currentPeriod,
                            staffId: staffId ?? 1,
                            subjectClip: widget.subjectData.subjectClip,
                            subjectId: widget.subjectData.subjectIdSt,
                          ));
                        },
                        child: const Text(
                          'SUBMIT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
