import 'package:flutter/material.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/student_detail_page.dart';

class MySearchBar extends StatefulWidget {
  final VoidCallback showAlert;
  const MySearchBar({super.key, required this.showAlert});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late FocusNode myfocusNode;
  late TextEditingController serachTextController;
  late Color focusColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    serachTextController = TextEditingController();
    myfocusNode = FocusNode();
    myfocusNode.addListener(() {
      if (myfocusNode.hasFocus) {
        // Handle focus event here

        setState(() {
          focusColor = const Color(0xffE4DAFF);
        });
      } else {
        // Handle unfocus event here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Container(
        width: double.infinity,
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.6000000238418579),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
              side: BorderSide(color: focusColor)),
          shadows: const [
            BoxShadow(
              color: Color(0x07000000),
              blurRadius: 19.90,
              offset: Offset(-2, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: TextField(
            controller: serachTextController,
            focusNode: myfocusNode,
            onSubmitted: (value) {
              if (serachTextController.text.trim().length == 11) {
                String searchData = serachTextController.text.trim();
                serachTextController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentDetailPage(
                            studentRegNo: searchData.toUpperCase(),
                          )),
                );
              } else {
                widget.showAlert;
              }
            },
            onTapOutside: (event) {
              myfocusNode.unfocus();
              setState(() {
                focusColor = Colors.transparent;
              });
            },
            decoration: const InputDecoration(
                hintText: "Search for students register number",
                hintStyle: TextStyle(
                  color: Color(0xF2334149),
                  fontSize: 13,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.fromLTRB(12, 8, 12, 14),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search)),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
