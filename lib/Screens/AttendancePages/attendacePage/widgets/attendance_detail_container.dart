import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

class AttendanceDetailContainer extends StatefulWidget {
  final ScheduleModel subjectDetails;
  final String date;
  final String className;
  final String yearName;

  const AttendanceDetailContainer({
    super.key,
    required this.date,
    required this.className,
    required this.yearName,
    required this.subjectDetails,
  });

  @override
  State<AttendanceDetailContainer> createState() =>
      _AttendanceDetailContainerState();
}

class _AttendanceDetailContainerState extends State<AttendanceDetailContainer> {
  //@vars
  late String romanYear;
  @override
  void initState() {
    //converting years into varous format shitty job
    switch (widget.yearName) {
      case ("1"):
        {
          romanYear = "I";
          break;
        }
      case ("2"):
        {
          romanYear = "II";
          break;
        }
      case ("3"):
        {
          romanYear = "III";
          break;
        }
      case ("4"):
        {
          romanYear = "IV";
          break;
        }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //@vars

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        gradient: const LinearGradient(
          begin: Alignment(1.00, 0.00),
          end: Alignment(-1, 0),
          colors: [
            Color.fromARGB(60, 150, 114, 248),
            Color.fromARGB(60, 251, 130, 196),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        shadows: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8.40,
            offset: Offset(-6, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.date,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 45, 40, 84),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: 0.07,
                    ),
                  ),
                  const Addheight(height: 4),
                  nameAndRegNo(widget.className,
                      widget.subjectDetails.subjectName, widget.date, romanYear)
                ],
              ),
              SizedBox(
                  height: 46,
                  width: 46,
                  child: Image.asset('lib/Assets/icons/attendanceFrame.png'))
            ]),
      ),
    );
  }

  Widget nameAndRegNo(
      String className, String subjectName, String date, String yearName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$className-$romanYear",
          style: const TextStyle(
            color: Color(0xCC00111C),
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
        const Addheight(height: 2),
        Text(
          subjectName.toUpperCase(),
          style: const TextStyle(
            color: Color.fromARGB(226, 49, 61, 73),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
          ),
        ),
      ],
    );
  }
}
