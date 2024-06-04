import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

class StudentDetailsContainer extends StatefulWidget {
  final String date;
  final String studentName;
  final String registerNo;

  const StudentDetailsContainer({
    super.key,
    required this.date,
    required this.studentName,
    required this.registerNo,
  });

  @override
  State<StudentDetailsContainer> createState() =>
      _StudentDetailsContainerState();
}

class _StudentDetailsContainerState extends State<StudentDetailsContainer> {
  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      Text(
                        'Synced reports ${widget.date}   ',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 45, 40, 84),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.07,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: Image.asset('lib/Assets/icons/green_tick.png'),
                      )
                    ],
                  ),
                  const Addheight(height: 4),
                  nameAndRegNo(widget.studentName, widget.registerNo)
                ],
              ),
              SizedBox(
                height: 46,
                width: 46,
                child: Image.asset(
                  'lib/Assets/icons/attendance.png',
                  scale: 3,
                ),
              )
            ]),
      ),
    );
  }

  Widget nameAndRegNo(String staffName, String staffRegNo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          staffName,
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
          " $staffRegNo",
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
