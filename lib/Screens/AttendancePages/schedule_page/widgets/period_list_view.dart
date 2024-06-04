import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/widgets/period_tile.dart';

Widget scheduleListview(
    List<ScheduleModel> scheduleList,
    int selectedYearId,
    int selectedClassId,
    int selectedDeptId,
    String selectedYearName,
    String selectedClassName,
    String selectedDeptName,
    String currentDate,
    int currentDayId) {
  return Expanded(
    child: Container(
      color: Colors.transparent,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: scheduleList.length,
          itemBuilder: (context, index) {
            //
            ScheduleModel currentData = scheduleList[index];
            //
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child:
                    // periodTile("19PHB103", 'Physics of Photonics', 1, 'AMIL-B-II'),
                    periodTile(
                        currentData,
                        context,
                        selectedYearId,
                        selectedClassId,
                        selectedDeptId,
                        selectedYearName,
                        selectedClassName,
                        selectedDeptName,
                        currentDate,
                        currentDayId));
          }),
    ),
  );
}
