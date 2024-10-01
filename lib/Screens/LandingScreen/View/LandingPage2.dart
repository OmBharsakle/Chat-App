import 'package:chat_app/Screens/AuthScreen/LoginPage.dart';
import 'package:equal_space/equal_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../AuthScreen/RegisterPage.dart';

class LandingPage2 extends StatelessWidget {
  const LandingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width.w;
    double screenHeight = MediaQuery.of(context).size.height.h;
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 60.h,),
            Expanded(child: Container(
              width: screenWidth.w,
              height: screenHeight/5.h,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/chat.png')),
              ),
            )),
            Expanded(child: SpacedColumn(
              space: 20,
              children: [
                Text('Everything You Message is in One Place Now',style: Theme.of(context).textTheme.displayMedium,textAlign: TextAlign.center,),
                Text('Find your daily necessities at Brand. The worlds largest fashion e-commerce has arrived in a mobile shop now! ',style:  Theme.of(context).textTheme.labelSmall,textAlign: TextAlign.center,),
                SizedBox(height: 2.h,),
                GestureDetector(
                  onTap: () {
                    Get.to(const LoginPage());
                  },
                  child: Container(
                    width: screenWidth.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: CupertinoColors.activeBlue,
                    ),
                    alignment: Alignment.center,
                    child: const Text('Login',style: TextStyle(fontSize: 16.5,color: Colors.white,letterSpacing: 1,fontWeight: FontWeight.w600),),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const SignUpPage());
                  },
                  child: Container(
                    width: screenWidth.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 1,color: Theme.of(context).colorScheme.onPrimary,)
                      // color: CupertinoColors.activeBlue,
                    ),
                    alignment: Alignment.center,
                    child: Text('Register',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600,letterSpacing: 1.4),),
                  ),
                ),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}
