import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool localValue = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 18,
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
              const Text(
                'Remember me',
                style: TextStyle(
                  color: Color(0xFF012970),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                  letterSpacing: 0.24,
                ),
              )
            ],
          ),
        ),
        const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(0xFF4154F1),
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            height: 0,
            letterSpacing: 0.24,
          ),
        )
      ],
    );
  }
}
