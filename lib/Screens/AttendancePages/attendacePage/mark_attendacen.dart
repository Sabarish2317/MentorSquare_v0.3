import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/bloc/get_students_list_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/bloc/save_attendance_bloc.dart';

import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/widgets/attendance_detail_container.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/widgets/grid_listview.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/app_text_logo.dart';

class MarkAttendancePage extends StatefulWidget {
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
  const MarkAttendancePage({
    super.key,
    required this.subjectData,
    required this.selectedYearId,
    required this.selectedClassId,
    required this.selectedDeptId,
    required this.selectedYearName,
    required this.selectedClassName,
    required this.selectedDeptName,
    required this.currentDate,
    required this.currentDayId,
    required this.currentPeriod,
  });

  @override
  State<MarkAttendancePage> createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  // Bloc instance
  late final GetStudentsListBloc _getStudentsListBloc;
  late final SaveAttendanceBloc _saveAttendanceBloc;
  //
  //
  //

  //

  @override
  void initState() {
    super.initState();
    _getStudentsListBloc = GetStudentsListBloc();
    _saveAttendanceBloc = SaveAttendanceBloc();
    _fetchStudentsData();
  }

  void _fetchStudentsData() {
    _getStudentsListBloc
        .add(GetStudentListActionEvent(classId: widget.selectedClassId));
  }

  @override
  void dispose() {
    _getStudentsListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.purple,
        bottomOpacity: 0,
        toolbarOpacity: 0,
        backgroundColor: const Color(0xffECF2FF),
        centerTitle: true,
        title: appTextLogo(),
      ),
      backgroundColor: const Color(0xffECF2FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AttendanceDetailContainer(
                  className: widget.subjectData.className,
                  date: widget.currentDate,
                  yearName: widget.selectedYearName,
                  subjectDetails: widget.subjectData,
                ),
              ),
              const Addheight(height: 15),
              BlocProvider(
                create: (context) => GetStudentsListBloc(),
                child: BlocListener<GetStudentsListBloc, GetStudentsListState>(
                  listener: (context, state) {},
                  child: BlocBuilder<GetStudentsListBloc, GetStudentsListState>(
                    bloc: _getStudentsListBloc, // Use the same instance here
                    builder: (context, state) {
                      if (state is GetStudentsListsLoadingState) {
                        return const CircularProgressIndicator();
                      } else if (state is GetStudentsListSuccesState) {
                        return GridListview(
                            saveAttendacenBloc: _saveAttendanceBloc,
                            studentsData: state.studentsList,
                            subjectData: widget.subjectData,
                            selectedYearId: widget.selectedYearId,
                            selectedClassId: widget.selectedClassId,
                            selectedDeptId: widget.selectedDeptId,
                            selectedYearName: widget.selectedYearName,
                            selectedClassName: widget.selectedClassName,
                            selectedDeptName: widget.selectedDeptName,
                            currentDate: widget.currentDate,
                            currentDayId: widget.currentDayId,
                            currentPeriod: widget.currentPeriod);
                      } else {
                        return const Text('An error occurred');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
