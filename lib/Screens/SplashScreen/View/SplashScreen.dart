import 'dart:async';
import 'package:chat_app/Screens/AuthScreen/AuthManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;

    Timer(const Duration(seconds: 5), () => Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const AuthManager(),
      ),
    ),);

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/SplashScreen.png'),fit: BoxFit.cover),
        ),
      ),
    );
  }
}
