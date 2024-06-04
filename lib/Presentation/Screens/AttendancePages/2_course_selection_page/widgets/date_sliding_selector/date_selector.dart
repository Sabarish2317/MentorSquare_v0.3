import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/ui_consts/colors.dart';
import 'package:mentor_square/ui_consts/them_data.dart';

class MyDateSlider extends StatefulWidget {
  const MyDateSlider({super.key});

  @override
  State<MyDateSlider> createState() => _MyDateSliderState();
}

class _MyDateSliderState extends State<MyDateSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(child: timeLinethemeVariant());
  }
}

EasyDateTimeLine timeLinethemeVariant() {
  return EasyDateTimeLine(
    headerProps:
        const EasyHeaderProps(showSelectedDate: false, showHeader: false),

    timeLineProps: EasyTimeLineProps(separatorPadding: 10.w),
    //
    /*Active styles*/

    dayProps: EasyDayProps(
        height: 55.h,
        width: 45.75.w,
        //disabling defualt value for today box
        todayHighlightColor: tdgray,
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(
                color: Color(0xff546683),
                width: 1,
              )),
              color: tdPurePurple,
              borderRadius: BorderRadius.all(Radius.circular(12.h))),
          monthStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xffD0D3FC), fontSize: 10),
          dayStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xffD0D3FC), fontSize: 10),
          dayNumStyle: appTheme.textTheme.labelLarge
              ?.copyWith(color: const Color(0xff344054), fontSize: 12),
        ),
        //
        /*Active styles*/
        //
        //
        /*inactive styles*/
        inactiveDayStyle: DayStyle(
          dayNumStyle: appTheme.textTheme.labelLarge
              ?.copyWith(color: tdPurePurple, fontSize: 12.sp),
          dayStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xff344054), fontSize: 12),
          monthStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xff344054), fontSize: 12),
          decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(
                width: 1,
                color: tdPurePurple,
              )),
              color: const Color(0xffD0D3FC),
              borderRadius: BorderRadius.all(Radius.circular(12.h))),
        ),
        todayStyle: DayStyle(
          dayNumStyle: appTheme.textTheme.labelLarge
              ?.copyWith(color: tdPurePurple, fontSize: 12.sp),
          dayStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xff344054), fontSize: 12),
          monthStrStyle: appTheme.textTheme.bodyLarge
              ?.copyWith(color: const Color(0xff344054), fontSize: 12),
          decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(
                width: 1,
                color: tdPurePurple,
              )),
              color: const Color(0xffD0D3FC),
              borderRadius: BorderRadius.all(Radius.circular(12.h))),
        )),
    initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
      //`selectedDate` the new date selected.
    },
  );
}
