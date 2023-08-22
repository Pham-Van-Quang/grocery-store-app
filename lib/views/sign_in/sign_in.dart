// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/authentication.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/common/textfield_custom.dart';
import 'package:grocery_store_app/router/app_routers.dart';
import 'package:grocery_store_app/views/sign_in/view_models/sign_in_cubit.dart';
import 'package:grocery_store_app/views/sign_in/view_models/sign_in_state.dart';
import 'package:hive/hive.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, required String title});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final _signInCubit = context.read<SignInCubit>();
  late Box box_1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
            child: Column(
              children: [
                const _SigninHeader(),
                SizedBox(height: 31.h),
                SizedBox(
                    height: 193.h,
                    child: Center(
                        child: SvgPicture.asset('assets/icons/image-2.svg'))),
                SizedBox(height: 33.h),
                TextfieldCustom(
                  controller: _signInCubit.email,
                  onTap: () => state.emailFocused,
                  onChanged: (value) => state.emailFocused,
                  hintText: 'Số điện thoại',
                ),
                SizedBox(height: 12.h),
                TextfieldCustom(
                  controller: _signInCubit.passWord,
                  onTap: () => state.passwordFocused,
                  onChanged: (value) => state.passwordFocused,
                  hintText: 'Mật khẩu',
                  obscureText: !state.showedPassword,
                  child_2: InkWell(
                      onTap: () => _signInCubit.showedPassword(),
                      child: SvgPicture.asset(
                          state.showedPassword
                              ? 'assets/icons/open-eye.svg'
                              : 'assets/icons/hidden-eye.svg',
                          color: state.showedPassword ? kTextColor : null)),
                ),
                SizedBox(height: 22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRouterName.forgottenpassword);
                      },
                      child: Text(
                        'Quên mật khẩu',
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 22.h),
                _ValidateEmail(signInCubit: _signInCubit),
                SizedBox(height: 180.h),
                const _SignUp()
              ],
            ),
          ),
        );
      },
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
              fontFamily: 'SVN-Avo',
              fontWeight: FontWeight.w700))
    ]));
  }
}

class _ValidateEmail extends StatelessWidget {
  const _ValidateEmail({
    required SignInCubit signInCubit,
  }) : _signInCubit = signInCubit;

  final SignInCubit _signInCubit;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        try {
          await Auth().loginWithEmailAndPassword(
              email: _signInCubit.email.text.trim(),
              password: _signInCubit.passWord.text.trim());
          Navigator.pushNamed(context, AppRouterName.homepage);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Center(
                      child: Text('Thông báo',
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    content: const Text(
                        'Email hoặc mật khẩu không đúng\nVui lòng thử lại!'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          child: const Text('Đồng ý'))
                    ],
                  ));
        }
      },
      text: 'Đăng nhập',
    );
  }
}

class _SigninHeader extends StatelessWidget {
  const _SigninHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(onTap: () {
          Navigator.pop(context);
        }),
        Text('Bắt đầu ngay', style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
