import 'package:flutter/material.dart';

Widget gridHeader(BuildContext context, ValueChanged<bool> onPressed) {
  return Column(
    children: [
      const Divider(
        height: 1,
        color: Color(0xFFB0B4EB),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: const BoxDecoration(color: Color(0x198D8CF5)),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Flexible(
                  flex: 15,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 0,
                      ),
                      child: Text(
                        'Reg.No',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF344054),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  )),
              verticalDiv(),
              const Flexible(
                  flex: 15,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 0,
                      ),
                      child: Text(
                        'Student Name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF344054),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  )),
              verticalDiv(),
              Flexible(
                  flex: 10,
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 0,
                        ),
                        child: GridCheckBox(
                          onPressed: onPressed,
                        )),
                  )),
            ],
          ),
        ),
      ),
      const Divider(
        height: 1,
        color: Color(0xFFB0B4EB),
      ),
    ],
  );
}

class GridCheckBox extends StatefulWidget {
  final ValueChanged<bool> onPressed;
  const GridCheckBox({super.key, required this.onPressed});

  @override
  State<GridCheckBox> createState() => _GridCheckBoxState();
}

class _GridCheckBoxState extends State<GridCheckBox> {
  bool localValue = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: 25,
        height: 18,
        child: Checkbox(
          value: localValue,
          onChanged: (bool? newValue) {
            setState(() {
              localValue = newValue!;
              widget.onPressed(newValue);
            });
          },
        ),
      ),
    );
  }
}

Widget verticalDiv() {
  return Container(
    width: 1,
    decoration: const ShapeDecoration(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 1,
          strokeAlign: BorderSide.strokeAlignCenter,
          color: Color(0xFFB0B4EB),
        ),
      ),
    ),
  );
}
