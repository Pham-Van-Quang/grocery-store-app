import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/router/app_routers.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 53.h, 20.w, 40.h),
        child: Column(
          children: [
            const Row(
              children: [
                BackButton(),
              ],
            ),
            SizedBox(
              height: 149.h,
            ),
            SizedBox(
              height: 255.h,
              child: Center(
                child: SvgPicture.asset('assets/icons/image-5.svg'),
              ),
            ),
            SizedBox(height: 236.h),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouterName.homepage);
              },
              text: 'Bắt đầu mua sắm',
            )
          ],
        ),
      ),
    );
  }
}
