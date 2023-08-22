// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/common/action_question.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_click.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/router/app_routers.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String defaultImageAsset = "assets/images/add-image.jpg";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
        child: Column(
          children: [
            const _AccountHeader(),
            SizedBox(height: 54.h),
            const _Avatar(),
            SizedBox(height: 22.h),
            Column(
              children: [
                Text('Phạm Văn Quang',
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: kTextColor,
                        fontWeight: FontWeight.bold)),
                Text(FirebaseAuth.instance.currentUser?.email ?? "",
                    style: Theme.of(context).textTheme.bodyLarge)
              ],
            ),
            SizedBox(height: 58.h),
            ClickButton(
              onTap: () {
                Navigator.pushNamed(context, AppRouterName.personalinfor);
              },
              icon: SvgPicture.asset('assets/icons/person.svg'),
              text: 'Thông tin cá nhân',
            ),
            ClickButton(
              icon: SvgPicture.asset('assets/icons/lock.svg'),
              text: 'Đổi mật khẩu',
            ),
            const _LogoutOrNot(),
          ],
        ),
      ),
    );
  }
}

class _LogoutOrNot extends StatelessWidget {
  const _LogoutOrNot();

  @override
  Widget build(BuildContext context) {
    return ClickButton(
      onTap: () {
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) {
              return ActionQuestion(
                onPressed: () async {
                  await Auth().logOut();
                  Navigator.popAndPushNamed(context, AppRouterName.onboarding);
                },
                text: 'Đăng xuất',
              );
            });
      },
      icon: SvgPicture.asset('assets/icons/log-out.svg'),
      text: 'Đăng xuất',
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98.w,
      width: 98.w,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.08)),
          ]),
      padding: EdgeInsets.all(3.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(75),
        child: Image.network(
          Auth().currentUser?.photoURL ?? "",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _AccountHeader extends StatelessWidget {
  const _AccountHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(onTap: () {
          Navigator.pop(context);
        }),
        Text('Tài khoản', style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
