import 'package:chat_app/Screens/HomeScreen/View/HomePage.dart';
import 'package:chat_app/Utils/Global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../FireBase/AuthServices/SimpleAuth.dart';
import '../../FireBase/FireStore/UserStore.dart';
import '../../Modal/UserModel.dart';
import 'Components/TextField.dart';
import 'LoginPage.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight - (MediaQuery.of(context).padding.top - kToolbarHeight )
            ),
            child: IntrinsicHeight(

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    width: screenWidth.w,
                    height: screenHeight/3.h,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/register.png')),
                    ),
                  ),
                  ////// EMAIL SECTION
                  MyTextFormField(hintText: 'Enter Your Name',controller: nameController,text: 'Name',isObscure: false,),
                  // PASSWORD SECTION
                  // SizedBox(
                  //   height: 10,
                  // ),
                  MyTextFormField(hintText: 'Enter Your Email',controller: signUpEmailController,text: 'Email',isObscure: false,),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 55.h,
                    child: Obx(
                      () =>  TextFormField(
                        cursorColor: Color(0xFF00BF6D),
                        controller: signUpPassController,
                        style: GoogleFonts.lato(textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                getX.passShow();
                              },
                              child: Icon(
                                  getX.isObscure.value ? CupertinoIcons.eye : CupertinoIcons.eye_slash
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.onSecondary,
                            hintText: 'Enter Your Password',
                            hintStyle: GoogleFonts.lato()),
                        onTapOutside: (event) =>
                            FocusScope.of(context).requestFocus(FocusNode()),
                        obscureText: getX.isObscure.value,
                      ),
                    ),
                  ),
                  Text(
                    'Confirm Password',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
              SizedBox(
                      height: 55.h,
                      child: Obx(
                        () =>  TextFormField(
                          cursorColor: Color(0xFF00BF6D),
                          controller: confirmController,
                          style: GoogleFonts.lato(textStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  getX.passShow();
                                },
                                child: Icon(
                                    getX.isObscure.value ? CupertinoIcons.eye : CupertinoIcons.eye_slash
                                ),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.onSecondary,
                              hintText: 'Enter Your Confirm Password',
                              hintStyle: GoogleFonts.lato()),
                          onTapOutside: (event) =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          obscureText: getX.isObscure.value,
                        ),
                      ),
                    ),

                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if(signUpPassController.text.toString()==confirmController.text.toString())
                      {
                        await SimpleAuth.simpleAuth.createAccountWithEmailAndPassword(signUpEmailController.text, signUpPassController.text);
                        UserModel userModel = UserModel(name: nameController.text, email: signUpEmailController.text, image: getRandomProfileImage(), phone:  '+91 7490835410', token: '',timestamp: Timestamp.now(),aboutUs: getRandomCaption());
                        FirebaseCloudServices.firebaseCloudServices.insertUserIntoFireStore(userModel);
                        signUpPassController.clear();
                        signUpEmailController.clear();
                        confirmController.clear();
                        nameController.clear();
                        Get.back();
                      }
                      else{
                        const GetSnackBar(title: "Password Can't Not Match!!",);
                      }
                    },
                    child: Container(
                      width: screenWidth.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF00BF6D),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 16.5,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  // ----------------------------------
                  SizedBox(
                    height: 15.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(LoginPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        Text("Sign in.",style: TextStyle(color:Color(0xFF00BF6D)),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
