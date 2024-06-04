import 'package:flutter/material.dart';

class GridRowTile extends StatefulWidget {
  final String regNo;
  final String studentName;
//this value is given by the parent (header checkbox button )
  final bool attStatus;
//call back funtion to report the changed value to parent widget
  final ValueChanged<bool> onPressed;
  const GridRowTile(
      {super.key,
      required this.regNo,
      required this.studentName,
      required this.attStatus,
      required this.onPressed});

  @override
  State<GridRowTile> createState() => _GridRowTileState();
}

class _GridRowTileState extends State<GridRowTile> {
  late bool localValue = widget.attStatus;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 15,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 0,
                  ),
                  child: Text(
                    widget.regNo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF334149),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            verticalDiv(),
            Flexible(
              flex: 15,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 0,
                  ),
                  child: Text(
                    widget.studentName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF334149),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            verticalDiv(),
            Flexible(
              flex: 10,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 0,
                  ),
                  child: GestureDetector(
                    child: SizedBox(
                      width: 25,
                      height: 18,
                      child: Checkbox(
                        activeColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              5.0), // Set your desired radius here
                        ),
                        checkColor: Colors.green,
                        side: const BorderSide(color: Colors.purple),
                        fillColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        value: widget.attStatus,
                        onChanged: (bool? newValue) {
                          setState(() {
                            localValue = newValue!;
                            widget.onPressed(newValue);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
