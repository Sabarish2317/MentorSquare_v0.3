import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../ui_consts/colors.dart';
import '../../../ui_consts/them_data.dart';
import '../../global_widgets/add_height.dart';
import '../../global_widgets/name_grid.dart';

class MyBottomUp extends StatefulWidget {
  final Widget widget;
  const MyBottomUp({super.key, required this.widget});

  @override
  State<MyBottomUp> createState() => _MyBottomUpState();
}

class _MyBottomUpState extends State<MyBottomUp> {
  @override
  Widget build(BuildContext context) {
    //used a inkwell to wrap it so touiching anything wll pop it off wll impleent later when using backends

    //this is a custom bottomUp sheet it uses container and column to nest its widgets. Stack is used to bring the sheet on top of the current page the user is on.
    return InkWell(
      child: SizedBox(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 392.w,
              height: (MediaQuery.of(context).size.height) / 2.5,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0x4C8D8CF5),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(2, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Addheight(height: 5.h),
                  /*DEOCR*/ Container(
                    width: 59.w,
                    height: 5.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF9672F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  /*ui decorations are over place the widget you want to show in this column */
                  Padding(
                    padding: EdgeInsets.all(12.0.w),
                    child: widget.widget,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

//second bottomup to provide if you want to pop
class MyBottomUpPop extends StatefulWidget {
  final Widget widget;
  const MyBottomUpPop({super.key, required this.widget});

  @override
  State<MyBottomUpPop> createState() => _MyBottomUpPopState();
}

class _MyBottomUpPopState extends State<MyBottomUpPop> {
  @override
  Widget build(BuildContext context) {
    //used a inkwell to wrap it so touiching anything wll pop it off wll impleent later when using backends

    //this is a custom bottomUp sheet it uses container and column to nest its widgets. Stack is used to bring the sheet on top of the current page the user is on.
    var textList = [
      "I-Year",
      "II-Year",
      "III-Year",
      "IV-Year",
    ];
    return InkWell(
      child: SizedBox(
          child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 392.w,
              height: (MediaQuery.of(context).size.height) / 2.5,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0x4C8D8CF5),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(2, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Column(
                children: [
                  Addheight(height: 5.h),
                  /*DEOCR*/ Container(
                    width: 59.w,
                    height: 5.h,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF9672F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  /*ui decorations are over place the widget you want to show in this column */
                  Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: Column(
                        //goes inside the bottomup skeleton function
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Select Class Year",
                                style: appTheme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.sp)),
                          ),
                          Addheight(
                            height: 15.h,
                          ),
//refer isndie NameGrid class for further details.
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 20.h),
                            child: Column(
                              children: [
                                GridView.count(
                                  physics: const ScrollPhysics(),
                                  mainAxisSpacing: 16.w,
                                  crossAxisSpacing: 30.w,
                                  childAspectRatio: MediaQuery.of(context)
                                          .size
                                          .width /
                                      (MediaQuery.of(context).size.height / 4),
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  children:
                                      List.generate(textList.length, (index) {
                                    return Material(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: Color.fromRGBO(
                                                160, 159, 243, 0.15)),
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: InkWell(
                                        splashColor: tdgrayblue,
                                        enableFeedback: true,
                                        hoverColor: tdPurePurple,
                                        borderRadius: BorderRadius.circular(19),
                                        child: Container(
                                            width: 124.w,
                                            height: 61.h,
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF9672F8),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 0.50,
                                                    color: Color.fromRGBO(
                                                        119, 118, 181, 0.149)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                textList.elementAt(index),
                                                style: appTheme
                                                    .textTheme.titleSmall
                                                    ?.copyWith(
                                                        color: tdBgColor,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                            )),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
