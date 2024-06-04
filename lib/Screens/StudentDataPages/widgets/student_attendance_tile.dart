import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_sad_model.dart';

import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

Widget sadTile(StudentSad studentData) {
  final StudentSad currentStudentData = studentData;
  //to handle present and absetn percentage fot data
  double presentPercentage = studentData.subjectPercentage;
  final List<ChartData> chartData = [
    ChartData(
      'absent Percentage',
      100 - presentPercentage,
      const Color(0xff202D43),
    ),
    ChartData('Present Percentage', presentPercentage, const Color(0xffB5ACF5)),
  ];
  final List<Color> innerColors = [
    const Color(0xff202D43), // color for Steve
    const Color(0xffB5ACF5) // color for David
  ];
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.6000000238418579),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, 0),
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //divcider
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 5,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF9672F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const Addheight(
                  width: 18,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentStudentData.subjectName,
                          style: const TextStyle(
                            color: Color(0xCC00111C),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        const Addheight(
                          height: 4,
                        ),
                        Text(
                          studentData.subjectCode,
                          style: const TextStyle(
                            color: Color(0xFF615E82),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.06,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'ATTENDANCE :',
                          style: TextStyle(
                            color: Color.fromARGB(255, 21, 44, 61),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            letterSpacing: 0.06,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${studentData.presentClassCount}/${studentData.totalClassCount}',
                          style: const TextStyle(
                            color: Color(0xFF4154F1),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 0.06,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
                width: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SfCircularChart(series: <CircularSeries>[
                      DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        pointColorMapper: (ChartData data, _) =>
                            innerColors[chartData.indexOf(data)],
                        // Radius of doughnut
                        radius: '130%',
                        innerRadius: '70%',
                      )
                    ]),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${presentPercentage.toInt()}%',
                          style: const TextStyle(
                            color: Color(0xFF1E1B39),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: 0.07,
                          ),
                        ),
                        Text(
                          (presentPercentage > 75) ? ("GOOD") : ("POOR"),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (presentPercentage > 75)
                                ? (const Color(0xFF50B40D))
                                : (Colors.red),
                            fontSize: 8,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.04,
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ]),
    ),
  );
}
