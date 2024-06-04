import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/login_screen.dart';
import 'package:mentor_square_v3_responsive/constants/colors.dart';
import '../LoginPage/widget/app_logo.dart';
import '../landingPage/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<int?> getStaffIdFromSS() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'staffId');
    return value != null ? int.tryParse(value) : null;
  }

  @override
  void initState() {
    super.initState();
    _navigateBasedOnStaffId();
  }

  void _navigateBasedOnStaffId() async {
    // Add a delay of 2 seconds
    await Future.delayed(const Duration(seconds: 1));

    final int? staffId = await getStaffIdFromSS();
    if (staffId == null || staffId == 0) {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (_, __, ___) => const LoginPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => const LandingPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      body: Center(child: appLogo()),
    );
  }
}
