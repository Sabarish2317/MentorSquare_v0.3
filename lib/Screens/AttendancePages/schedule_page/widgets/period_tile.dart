import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/mark_attendacen.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

Widget periodTile(
    ScheduleModel scheduledata,
    BuildContext context,
    int selectedYearId,
    int selectedClassId,
    int selectedDeptId,
    String selectedYearName,
    String selectedClassName,
    String selectedDeptName,
    String currentDate,
    int currentDayId) {
  return Container(
    decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: const Color.fromARGB(180, 255, 255, 255)),
    child: Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.transparent,
      child: InkWell(
        splashColor: const Color.fromARGB(255, 211, 203, 233),
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  MarkAttendancePage(
                subjectData: scheduledata,
                selectedYearId: selectedYearId,
                selectedClassId: selectedClassId,
                selectedDeptId: selectedDeptId,
                selectedYearName: selectedYearName,
                selectedClassName: selectedClassName,
                selectedDeptName: selectedDeptName,
                currentDate: currentDate,
                currentDayId: currentDayId,
                currentPeriod: scheduledata.periodNo,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0,
                    0.0); // Start offset for slide animation (right to left)
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 19.90,
                offset: Offset(0, 0),
                spreadRadius: 2,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 5,
                  height: 40,
                  decoration: ShapeDecoration(
                    color: const Color(0xE59672F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x4C9672F8),
                        blurRadius: 20,
                        offset: Offset(0, 0),
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
                const Addheight(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scheduledata.subjectCode,
                      style: const TextStyle(
                        color: Color(0xCC00111C),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const Addheight(height: 4),
                    Text(
                      scheduledata.subjectName,
                      style: const TextStyle(
                        color: Color(0xCC253342),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const Addheight(width: 12),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          colorContainer(scheduledata.periodNo),
                          const Addheight(height: 4),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              scheduledata.className,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: Color(0xCC334149),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget colorContainer(int periodNo) {
  return Container(
    width: 90,
    height: 20,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: const Color(0x4C7CC749),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      shadows: const [
        BoxShadow(
          color: Color(0x07000000),
          blurRadius: 19.90,
          offset: Offset(-2, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Period - $periodNo',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xF2334149),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
        SizedBox(
            height: 12,
            width: 12,
            child: Image.asset('lib/Assets/icons/sun_icon.png')),
      ],
    ),
  );
}
