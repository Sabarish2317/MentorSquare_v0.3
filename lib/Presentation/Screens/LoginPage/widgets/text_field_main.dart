import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../ui_consts/icons_const.dart';

// ignore: must_be_immutable
class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String preffixIcon;
  final String suffixIcon;
  final String suffixIconOn;
  final String labelText;

  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPassword = false,
      required this.preffixIcon,
      this.suffixIconOn = nullImg,
      this.suffixIcon = nullImg,
      required this.labelText});

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  late bool isOnOff = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isOnOff,
      style: const TextStyle(
          color: Color(0xFF6B6B6B),
          fontSize: 16,
          fontFamily: 'Lato',
          fontWeight: FontWeight.w500,
          letterSpacing: 0.10),
      decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 50.h),
          isDense: true,
          prefixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 12.0, end: 12.0),
            child: Image.asset(
              widget.preffixIcon,
              height: 24,
              width: 24,
            ),
          ),
          suffixIcon: IconButton(
              splashRadius: 25,
              onPressed: () {
                setState(
                  () {
                    isOnOff = !isOnOff;
                  },
                );
              },
              icon: Image.asset(
                  isOnOff ? widget.suffixIcon : widget.suffixIconOn,
                  height: 24,
                  width: 24)),
          border: InputBorder.none,
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: const TextStyle(
            color: Color(0xFF6B6B6B),
            fontSize: 13,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffE4DAFF)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff9672F8)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 168, 12, 12)),
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
