import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui_consts/them_data.dart';

class MyDropDownButton extends StatefulWidget {
  final String initialText;
  final Image? icon;
  final List<String> list;
  const MyDropDownButton(
      {super.key, required this.initialText, this.icon, required this.list});

  @override
  State<MyDropDownButton> createState() => _SheetsSemDropDownButtonState();
}

class _SheetsSemDropDownButtonState extends State<MyDropDownButton> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.initialText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD0D3FC), width: 1),
          color: const Color(0xffffffff),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      width: 142.w,
      height: 35.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: DropdownButton<String>(
          dropdownColor: const Color(0xffffffff),
          icon: widget.icon,
          isExpanded: true,
          borderRadius: BorderRadius.circular(10.h),
          elevation: 1,
          alignment: AlignmentDirectional.centerStart,
          style: appTheme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600, color: const Color(0xff344054)),
          underline: const SizedBox(),
          value: dropdownValue,
          onChanged: (newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: widget.list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 12.sp),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
