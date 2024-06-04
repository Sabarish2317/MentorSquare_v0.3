import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_square/Presentation/Screens/LoginPage/login_screen_page.dart';

void main() async {
  runApp(const MentorSquare());
} //main fucntion

class MentorSquare extends StatefulWidget {
  const MentorSquare({super.key});

  @override
  State<MentorSquare> createState() => _MyAppState();
}

class _MyAppState extends State<MentorSquare> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MentorSquare',
      home: LoginPage(),
    );
  }
}
