import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui_consts/them_data.dart';

class MyCheckBox extends StatefulWidget {
  final bool value;
  const MyCheckBox({super.key, required this.value});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    bool localValue = widget.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 18.h,
          child: Row(
            children: [
              SizedBox(
                width: 25,
                height: 18,
                child: Checkbox(
                  value: localValue,
                  onChanged: (bool? newValue) {
                    setState(() {
                      localValue = newValue!;
                    });
                  },
                ),
              ),
              Text(
                'Remember me',
                style: appTheme.textTheme.labelMedium?.copyWith(
                    color: const Color.fromARGB(255, 2, 41, 74), fontSize: 12),
              )
            ],
          ),
        ),
        Text('Forgot Password',
            style: appTheme.textTheme.labelMedium?.copyWith(fontSize: 12))
      ],
    );
  }
}
