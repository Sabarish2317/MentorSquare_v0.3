import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/widgets/global_widgets/add_height.dart';

import '../../../../../ui_consts/icons_const.dart';
import '../../../../../ui_consts/them_data.dart';

class MyTile extends StatefulWidget {
  final String titleText;
  final String subtitleText;
  final Widget navigateTo;
  const MyTile(
      {super.key,
      required this.titleText,
      required this.subtitleText,
      required this.navigateTo});

  @override
  State<MyTile> createState() => _MyTileState();
}

class _MyTileState extends State<MyTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.navigateTo,
                )),
            child: Container(
              width: 350.92.w,
              height: 80.h,
              decoration: ShapeDecoration(
                color: const Color.fromARGB(255, 247, 245, 250),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0.50,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0x4C8D8CF5),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 36,
                              decoration: const ShapeDecoration(
                                color: Color(0xFF8D8CF5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15.w, 0, 0, 0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.titleText,
                                    style: appTheme.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: const Color.fromARGB(
                                                255, 39, 36, 66),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp),
                                  ),
                                  Addheight(height: 5.h),
                                  Text(
                                    widget.subtitleText,
                                    style: appTheme.textTheme.bodyLarge
                                        ?.copyWith(
                                            color: const Color.fromARGB(
                                                204, 3, 1, 40),
                                            fontSize: 18.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Addheight(
                                width: MediaQuery.of(context).size.width / 5),
                            Image.asset(
                              downArrow,
                              height: 8.h,
                              color: const Color(0xff8D8CF5),
                            )
                          ],
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
