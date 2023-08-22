// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/common/custom_box.dart';
import 'package:grocery_store_app/router/app_routers.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 116.h, right: 20.w),
        child: Column(
          children: [
            SizedBox(
              height: 182.h,
              child: Center(
                child: SvgPicture.asset('assets/icons/image-1.svg'),
              ),
            ),
            SizedBox(height: 44.h),
            CustomBox(
              text: 'Đăng nhập bằng Facebook',
              child: Image.asset('assets/images/facebook.png'),
            ),
            SizedBox(height: 12.h),
            CustomBox(
              onTap: () async {
                await Auth().signInWithGoogle();
                Navigator.pushNamed(context, AppRouterName.homepage);
              },
              text: 'Đăng nhập bằng Google',
              child: Image.asset('assets/images/google.png'),
            ),
            SizedBox(height: 12.h),
            CustomBox(
              text: 'Đăng nhập bằng Apple',
              child: Image.asset('assets/images/apple.png'),
            ),
            SizedBox(height: 44.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: 144.w,
                  color: kThirdColor,
                ),
                Text(
                  'Hoặc',
                  style: TextStyle(color: kTextColor, fontSize: 14.sp),
                ),
                Container(
                  height: 1,
                  width: 144.w,
                  color: kThirdColor,
                ),
              ],
            ),
            SizedBox(height: 54.h),
            CustomButton(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRouterName.signin),
              text: 'Đăng nhập bằng E-mail',
            ),
            SizedBox(height: 70.h),
            const _SignUp()
          ],
        ),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  const _SignUp();

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Bạn chưa có tài khoản? ',
          style: TextStyle(
              color: kTextColor, fontSize: 14.sp, fontFamily: 'SVN-Avo')),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, AppRouterName.signup);
            },
          text: 'Đăng ký',
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              fontFamily: 'SVN-Avo'))
    ]));
  }
}
