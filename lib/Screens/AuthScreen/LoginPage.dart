import 'package:chat_app/Screens/AuthScreen/RegisterPage.dart';
import 'package:chat_app/Screens/HomeScreen/View/HomePage.dart';
import 'package:chat_app/Utils/Global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../FireBase/AuthServices/GoogleAuth.dart';
import '../../FireBase/AuthServices/SimpleAuth.dart';
import '../ForgotPassword/View/ForgotPassword.dart';
import 'Components/TextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.h,
              ),
              Container(
                width: screenWidth.w,
                height: screenHeight/4.h,
                margin: EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/signin.png')),
                ),
              ),
              
              ////// EMAIL SECTION
              MyTextFormField(hintText: 'Enter Your Email',controller: signInEmailController,text: 'Email',isObscure: false,),
              // PASSWORD SECTION
              SizedBox(
                height: 6.h,
              ),
              Text(
                'Password',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 50.h,
                child: Obx(
                      () =>  TextFormField(
                    cursorColor: Color(0xFF00BF6D),
                    controller: signInPassController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(child:
                    Text('Forget Password?',
                    style: Theme.of(context).textTheme.bodyMedium,),onPressed: () {
                      Get.to(ForgotPasswordScreen());
                    },
                  ),
                ],
              ),
              // LOGIN BUTTON
              SizedBox(
                height: 3.h,
              ),
              GestureDetector(
                onTap: () async {
                  String response = await SimpleAuth.simpleAuth.signInWithEmailAndPassword(
                      signInEmailController.text,
                      signInPassController.text);
                  User? user = SimpleAuth.simpleAuth.getCurrentUser();
                  if(user!=null && response == "Success")
                  {
                    Get.offAll(HomeScreen());
                  }else{
                    Get.snackbar("Sign In Failed !", response);
                  }
                },
                child: Container(
                  width: screenWidth.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color(0xFF00BF6D),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                      style: TextStyle(fontSize: 16.5,color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(SignUpPage());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",style: Theme.of(context)
                        .textTheme
                        .bodyMedium),
                    Text(" Register",style: TextStyle(color: Color(0xFF00BF6D)),),
          
                  ],
                ),
              ),
              // Other LOGIN SECTION
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Or Login With',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(letterSpacing: 1.5),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              // GOOGLE FACEBOOK APPLE
              SizedBox(
                height: 25.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Container(
                    width: screenWidth / 4.w,
                    height: 45.h,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Theme.of(context).colorScheme.onSurface)),
                    child: Icon(Bootstrap.github,size: 30,color: Theme.of(context).colorScheme.onPrimary,),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await GoogleAuthService.googleAuthService.signInWithGoogle();
                      User? user = SimpleAuth.simpleAuth.getCurrentUser();
                      if(user!=null)
                      {
                        Get.offAll(HomeScreen());
                      }
                    },
                    child: Container(
                      width: screenWidth / 4.w,
                      height: 45.h,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color:Theme.of(context).colorScheme.onSurface)),
                      child: Brand(Brands.google,),
                    ),
                  ),
                  Container(
                    width: screenWidth / 4.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color:Theme.of(context).colorScheme.onSurface)),
                    child: Icon(Bootstrap.apple,size: 30,color: Theme.of(context).colorScheme.onPrimary,),
                  ),
                ],
              ),
              // Text Button
          
            ],
          ),
        ),
      ),
    );
  }
}
