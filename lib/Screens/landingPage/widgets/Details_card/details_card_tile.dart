import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_detail_model.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/student_detail_page.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/widgets/remark_button.dart';

class DetailTile extends StatefulWidget {
  final StudentDetail studentDetail;

  const DetailTile({super.key, required this.studentDetail});

  @override
  State<DetailTile> createState() => _DetailTileState();
}

class _DetailTileState extends State<DetailTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
          color: const Color.fromARGB(159, 255, 255, 255),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        child: InkWell(
          splashColor: const Color.fromARGB(255, 223, 218, 237),
          borderRadius: BorderRadius.circular(9),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudentDetailPage(
                        studentRegNo:
                            widget.studentDetail.studentRegNo.toUpperCase(),
                      )),
            );
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              shadows: const [
                BoxShadow(
                  color: Color(0x07000000),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                  spreadRadius: 3,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                            widget.studentDetail.studentName,
                            style: const TextStyle(
                              color: Color(0xCC00111C),
                              fontSize: 18,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                          Text(
                            widget.studentDetail.studentRegNo,
                            style: const TextStyle(
                              color: Color(0xCC313D49),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: ShapeDecoration(
                          color: const Color(0x998D8CF5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Center(
                          child: SizedBox(
                              child: Icon(
                            size: 20,
                            Icons.favorite,
                            color: Color(0xff23324C),
                          )),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Color(0xffB0B4EB),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                            child: Text(
                              'Class',
                              style: TextStyle(
                                color: Color(0xFF00111C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.studentDetail.className,
                                    style: const TextStyle(
                                      color: Color(0xFF4154F1),
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            child: Text(
                              'Period',
                              style: TextStyle(
                                color: Color(0xFF00111C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                            child: Text(
                              '${75} Days',
                              style: TextStyle(
                                color: Color(0xFF344054),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      remarkButton(widget.studentDetail.yearName)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
