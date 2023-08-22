// ignore_for_file: unused_local_variable, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/router/app_routers.dart';
import 'package:grocery_store_app/views/splash_screen/view_model/splash_screen_cubit.dart';
import 'package:grocery_store_app/views/splash_screen/view_model/splash_screen_state.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required String title});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Box box_1;

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.location,
    ].request();
    if (await Permission.storage.request().isGranted) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, AppRouterName.widgettree);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashScreenCubit, SplashScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 310.h, bottom: 100.h),
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo.png'),
              ),
              if (state.isLoading)
                SpinKitChasingDots(
                  color: kPrimaryColor,
                  size: 30.h,
                )
            ],
          ),
        );
      },
    );
  }
}
