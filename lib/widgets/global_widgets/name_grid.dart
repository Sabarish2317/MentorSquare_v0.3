import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mentor_square/ui_consts/them_data.dart';

import '../../ui_consts/colors.dart';

class NameGrid extends StatelessWidget {
  final List textList;
  final Widget navigateTo;
  const NameGrid({super.key, required this.textList, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Scaffold(
        body: Column(
          children: [
            GridView.count(
              physics: const ScrollPhysics(),
              mainAxisSpacing: 16.w,
              crossAxisSpacing: 30.w,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 4),
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(textList.length, (index) {
                return Material(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.50,
                        color: Color.fromRGBO(160, 159, 243, 0.15)),
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: InkWell(
                    splashColor: tdgrayblue,
                    enableFeedback: true,
                    hoverColor: tdPurePurple,
                    borderRadius: BorderRadius.circular(19),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => navigateTo,
                        )),
                    child: Container(
                        width: 124.w,
                        height: 61.h,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF9672F8),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50,
                                color: Color.fromRGBO(119, 118, 181, 0.149)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            textList.elementAt(index),
                            style: appTheme.textTheme.titleSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp),
                          ),
                        )),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
