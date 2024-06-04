import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ui_consts/colors.dart';
import '../../../../ui_consts/them_data.dart';

class MyExpTile extends StatefulWidget {
  final String titleText;
  final String subtitleText;
  final String descriptiveText;
  const MyExpTile({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.descriptiveText,
  });

  @override
  State<MyExpTile> createState() => _MyExpTileState();
}

class _MyExpTileState extends State<MyExpTile> {
  @override
  Widget build(BuildContext context) {
    var selected = 0;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Container(
                width: 350.92.w,
                decoration: ShapeDecoration(
                  color: const Color.fromARGB(255, 247, 245, 250),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color.fromARGB(75, 255, 255, 255),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: ListTileTheme(
                  selectedColor: Colors.transparent,
                  contentPadding: EdgeInsets.fromLTRB(0, 8.h, 8.h, 8.h),
                  dense: true,
                  horizontalTitleGap: 13,
                  minLeadingWidth: 0,
                  child: Theme(
                    data: ThemeData(
                      dividerColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      initiallyExpanded: index == selected,
                      collapsedBackgroundColor:
                          const Color.fromARGB(0, 142, 140, 245),
                      collapsedIconColor: tdTlColor,
                      iconColor: tdPureBlue,
                      leading: Container(
                        width: 4.31.w,
                        height: 31.h,
                        decoration: const BoxDecoration(
                            color: Color(0xFF8D8CF5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          widget.titleText,
                          style: appTheme.textTheme.bodyLarge?.copyWith(
                              color: const Color.fromARGB(255, 39, 36, 66),
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp),
                        ),
                      ),
                      subtitle: Text(
                        widget.subtitleText,
                        style: appTheme.textTheme.bodyLarge?.copyWith(
                            color: const Color.fromARGB(204, 3, 1, 40),
                            fontSize: 18.sp),
                      ),
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 321.01.w,
                              decoration: const ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Color(0xCC615E82),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 14.h),
                              child: Text(widget.descriptiveText,
                                  style: appTheme.textTheme.bodyLarge?.copyWith(
                                      color:
                                          const Color.fromRGBO(0, 17, 28, 0.8),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w300)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          );
        });
  }
}
