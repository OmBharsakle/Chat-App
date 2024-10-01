import 'package:chat_app/Screens/AuthScreen/LoginPage.dart';
import 'package:chat_app/Screens/HomeScreen/View/HomePage.dart';
import 'package:chat_app/Screens/LandingScreen/View/LandingPage.dart';
import 'package:flutter/material.dart';

import '../../FireBase/AuthServices/SimpleAuth.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleAuth.simpleAuth.getCurrentUser() == null
        ? const LoginPage()
        :  const HomeScreen();
  }
}