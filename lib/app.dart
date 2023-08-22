import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/router/app_routers.dart';
import 'package:grocery_store_app/views/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        initialRoute: "/splashscreen",
        onGenerateRoute: AppRouter.onGeneratedRoute,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'SVN-Avo',
            textTheme: TextTheme(
              displayLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: kTextColor),
              displayMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.sp,
                  color: kTextColor),
              displaySmall: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: kTextColor),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: kTextColor),
              titleMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: kTextColor),
              bodyLarge: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.sp,
                  color: kTextColor),
              bodyMedium: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: kSecondaryColor),
              bodySmall: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.sp,
                  color: kThirdColor),
            )),
        home: const SplashScreen(title: ''),
      ),
    );
  }
}
