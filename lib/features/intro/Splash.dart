import 'dart:async';
import 'package:flutter/material.dart';
import '../nav_bar/nav_bar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001F3F),

      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 220,
          height: 220,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}