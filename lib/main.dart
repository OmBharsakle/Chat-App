import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/AuthScreen/AuthManager.dart';
import 'Screens/SplashScreen/View/SplashScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ),);

  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.blue[700]!,
              onPrimary: Colors.black,
              secondary: Colors.amber[700]!,
              onSecondary: Colors.white,
              error: Colors.red[800]!,
              onError: Colors.white,
              surface: Colors.grey[800]!,
              onSurface: Colors.black38,
            ),
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              // contentPadding:
              //     EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(15.r)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: const Color(0xFF00BF6D), width: 1.5.w),
                  borderRadius: BorderRadius.circular(15.r)),
            ),
            appBarTheme: AppBarTheme(
              toolbarHeight: 70.h,
              backgroundColor: Colors.transparent,
            ),
            textTheme: TextTheme(
              displayMedium: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 26.sp),
              ),
              labelSmall: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.sp),
              ),
              bodyMedium: GoogleFonts.lato(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
            )),
        darkTheme: ThemeData(
          colorScheme: ColorScheme(
            brightness: Brightness.dark,
            primary: Colors.blue[700]!,
            onPrimary: Colors.white,
            secondary: Colors.amber[700]!,
            onSecondary: Colors.black26,
            error: Colors.red[800]!,
            onError: Colors.black,
            surface: Colors.grey[800]!,
            onSurface: Colors.white30,
          ),
          scaffoldBackgroundColor: const Color(0xff181922),
          // scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            // contentPadding:
            //     EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.w),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.5.w,
                ),
                borderRadius: BorderRadius.circular(15.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: const Color(0xFF00BF6D), width: 1.5.w),
                borderRadius: BorderRadius.circular(15.r)),
          ),
          appBarTheme: AppBarTheme(
            toolbarHeight: 70.h,
            backgroundColor: Colors.transparent,
          ),
          textTheme: TextTheme(
            displayMedium: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26.sp),
            ),
            labelSmall: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp),
            ),
            bodyMedium: GoogleFonts.lato(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
            ),
          ),
        ),
        themeMode: ThemeMode.dark,
        home: const SplashScreen(),
      ),
    );
  }
}
