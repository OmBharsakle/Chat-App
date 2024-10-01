import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Controller/GetXController.dart';
import '../Modal/UserModel.dart';

// GetX Controller

MyGetXController getX = MyGetXController();

// Text Field Controller

TextEditingController signInEmailController = TextEditingController();
TextEditingController signInPassController = TextEditingController();
TextEditingController signUpEmailController = TextEditingController();
TextEditingController signUpPassController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController confirmController = TextEditingController();
TextEditingController txtMassage = TextEditingController();
List<UserModel> userModal = [];

// Profile Image List ----------------------------------------

final List<String> profileImages = [
  'assets/1.png',
  'assets/2.png',
  'assets/3.png',
  'assets/4.png',
  'assets/5.png',
  'assets/6.png',
  'assets/7.png',
  'assets/8.png',
  'assets/9.png',
  'assets/10.png',
  'assets/11.png',
  'assets/12.png',
  'assets/13.png',
  'assets/14.png',
  'assets/15.png',
  'assets/16.png',
  'assets/17.png',
  'assets/18.png',
  'assets/19.png',
  'assets/20.png',
];

// Method To Get a Random Profile Image --------------------

String getRandomProfileImage() {
  final random = Random();
  return profileImages[random.nextInt(profileImages.length)];
}

// Scroll Chat Screen -----------------------------

final ScrollController scrollController = ScrollController();

void scrollToBottom() {
  if (scrollController.hasClients) {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,  // Scroll to the max scroll extent (last message)
      duration: const Duration(milliseconds: 300), // Scroll duration
      curve: Curves.easeInOut, // Scroll animation curve
    );
  }
}

//

List<String> whatsappCaptions = [
  "If you can dream it, you can do it.",
  "Throw kindness around like confetti.",
  "A smiling face doesn’t always mean a smiling heart.",
  "Do what’s right.",
  "I came, I saw, I conquered.",
  "Don’t tell people your dreams, SHOW THEM!",
  "Don’t go through life, grow through life. Life is a one-time offer. Use it well.",
  "Believe you can and you’re halfway there.",
  "There’s bravery in being soft.",
  "Trust the timing of your life.",
  "Start each day with a grateful heart.",
  "Happiness is an inside job.",
  "Silence is the most powerful scream.",
  "Defeat your enemies with your success.",
  "The sun is new every day.",
  "Every day is a second chance.",
  "Every moment matters.",
  "Today is another chance to get better.",
  "Life is a beautiful struggle.",
  "It’s okay not to be perfect.",
  "Life begins at the end of your comfort zone.",
  "Keep moving! Nothing new to read.",
  "Hope anchors the soul.",
  "Life’s short, don’t miss a day.",
  "Let us die young or let us live forever.",
  "Be patient, good things take time.",
  "Do everything in love.",
  "Dream it. Wish it. Do it."
];

String getRandomCaption() {
  final random = Random();
  return whatsappCaptions[random.nextInt(whatsappCaptions.length)];
}


