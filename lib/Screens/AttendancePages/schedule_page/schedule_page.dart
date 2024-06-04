// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/bloc/schedule_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/widgets/period_list_view.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';
import 'package:mentor_square_v3_responsive/Widgets/app_text_logo.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  final Map<int, String> selectedYearIdx;
  final Map<int, String> selectedDeptIdx;
  final Map<int, String> selectedClassIdx;
  const SchedulePage({
    super.key,
    required this.selectedYearIdx,
    required this.selectedDeptIdx,
    required this.selectedClassIdx,
  });

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late ScheduleBloc _scheduleBloc;
  late var selectedYearId;
  late var selectedClassId;
  late var selectedDeptId;
  late var selectedYearName;
  late var selectedClassName;
  late var selectedDeptName;
  late String currentDate = _getTodaysDate();
  late int currentDayId = _getTodayDayId();

  @override
  void initState() {
    super.initState();
    //initiating parent blov
    _scheduleBloc = ScheduleBloc();
    //
    //initiating all late variables
    var yearEntry = widget.selectedYearIdx.entries.first;
    var deptEntry = widget.selectedDeptIdx.entries.first;
    var classEntry = widget.selectedClassIdx.entries.first;
    //isper initing late vars aftrer formatting
    selectedYearId = yearEntry.key;
    selectedDeptId = deptEntry.key;
    selectedClassId = classEntry.key;
    selectedYearName = yearEntry.value;
    selectedClassName = classEntry.value;
    selectedDeptName = deptEntry.value;

    //inititating functions required for the bloc to activate
    _fetchSchedule();
    _getTodaysDate();
    _getTodayDayId();
    print(_getTodayDayId());
  }

  String _getTodaysDate() {
    // Get the current date
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return formattedDate;
  }

  _getTOday() {
    DateTime now = DateTime.now();
    String dayName = DateFormat('EEEE').format(now);
    return dayName;
  }

  int _getTodayDayId() {
    late int dayid;
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEE').format(now).toLowerCase();

    switch (dayOfWeek) {
      case 'mon':
        dayid = 1;
        break;
      case 'tue':
        dayid = 2;
        break;
      case 'wed':
        dayid = 3;
        break;
      case 'thu':
        dayid = 4;
        break;
      case 'fri':
        dayid = 5;
        break;
      case 'sat':
        dayid = 6;
        break;
    }
    return dayid;
  }

  void _fetchSchedule() {
    print("remove this during producitons");
    _scheduleBloc.add(ScheduleListFetchEvent(
      selectedYear_id: selectedYearId.toString(),
      selectedClass_id: selectedClassId.toString(),
      selectedDay_id: 1.toString(),
    ));
  }

  @override
  void dispose() {
    _scheduleBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Converting int 2 into second year format
    String selectedYear = selectedYearName;
    // Concatenation
    String concat;
    if (selectedYear == '1') {
      concat = 'I';
    } else if (selectedYear == '2') {
      concat = 'II';
    } else if (selectedYear == '3') {
      concat = 'III';
    } else {
      concat = 'IV';
    }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$selectedClassName-$concat',
                        style: const TextStyle(
                          color: Color(0xFF00111C),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$currentDate - ${_getTOday()}',
                        style: const TextStyle(
                          color: Color(0xFF344054),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Addheight(height: 15),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'PERIOD SCHEDULE',
                    style: TextStyle(
                      color: Color(0xFF7D13BE),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Addheight(height: 15),
              BlocProvider(
                create: (context) => _scheduleBloc,
                child: BlocListener<ScheduleBloc, ScheduleState>(
                  listener: (context, state) {},
                  child: BlocBuilder<ScheduleBloc, ScheduleState>(
                    builder: (context, state) {
                      if (state is ScheduleFetchingLoadingState) {
                        const Center(child: CircularProgressIndicator());
                      } else if (state is ScheduleFetchingSuccessState) {
                        return scheduleListview(
                            state.scheduleData,
                            selectedYearId,
                            selectedClassId,
                            selectedDeptId,
                            selectedYear,
                            selectedClassName,
                            selectedDeptName,
                            currentDate,
                            currentDayId);
                      } else if (state is ScheduleApiFetchErrorState) {
                        return alertbox(state.message, context);
                      }
                      return const Text('No schedule available');
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
