// ignore_for_file: deprecated_member_use, use_build_context_synchronously

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
import 'package:grocery_store_app/views/sign_up/view_models/sign_up_cubit.dart';
import 'package:grocery_store_app/views/sign_up/view_models/sign_up_state.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final _signUpCubit = context.read<SignUpCubit>();
  late Box box_2;

  @override
  void initState() {
    hiveStorage();
    super.initState();
  }

  void hiveStorage() async {
    box_2 = await Hive.openBox('signupData');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
            child: Column(
              children: [
                const _SignupHeader(),
                SizedBox(height: 31.h),
                SizedBox(
                    height: 193,
                    child: Center(
                        child: SvgPicture.asset('assets/icons/image-4.svg'))),
                SizedBox(height: 33.h),
                TextfieldCustom(
                  controller: _signUpCubit.email,
                  onTap: () => state.emailFocused,
                  onChanged: (value) => state.emailFocused,
                  hintText: 'Số điện thoại',
                ),
                SizedBox(height: 12.h),
                TextfieldCustom(
                  controller: _signUpCubit.reenterPassword,
                  onTap: () => state.passwordFocused,
                  onChanged: (value) => state.passwordFocused,
                  hintText: 'Mật khẩu',
                ),
                SizedBox(height: 12.h),
                TextfieldCustom(
                  controller: _signUpCubit.passWord,
                  onTap: () => state.passwordFocused,
                  onChanged: (value) => state.passwordFocused,
                  hintText: 'Nhập lại mật khẩu',
                  obscureText: !state.showedPassword,
                  child_2: InkWell(
                      onTap: () => _signUpCubit.showedPassword(),
                      child: SvgPicture.asset(
                          state.showedPassword
                              ? 'assets/icons/open-eye.svg'
                              : 'assets/icons/hidden-eye.svg',
                          color: state.showedPassword ? kTextColor : null)),
                ),
                SizedBox(height: 53.h),
                _ValidateEmail(signUpCubit: _signUpCubit),
                SizedBox(height: 96.h),
                const _BackToSignin()
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BackToSignin extends StatelessWidget {
  const _BackToSignin();

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Bạn đã có tài khoản? ',
          style: TextStyle(
              color: kTextColor, fontSize: 14.sp, fontFamily: 'SVN-Avo')),
      TextSpan(
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.pushNamed(context, AppRouterName.signin);
            },
          text: 'Đăng nhập',
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
    super.key,
    required SignUpCubit signUpCubit,
  }) : _signUpCubit = signUpCubit;

  final SignUpCubit _signUpCubit;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () async {
        if (_signUpCubit.passWord.text.trim() ==
            _signUpCubit.reenterPassword.text.trim()) {
          await Auth().signupWithEmailAndPassword(
              email: _signUpCubit.email.text.trim(),
              password: _signUpCubit.passWord.text.trim());
          Navigator.pushNamed(context, AppRouterName.startscreen);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Lỗi', style: Theme.of(context).textTheme.titleLarge),
              content: const Text(
                  'Mật khẩu không khớp.\nVui lòng nhập lại mật khẩu.'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor),
                    child: const Text('Đồng ý'))
              ],
            ),
          );
        }
      },
      text: 'Đăng ký',
    );
  }
}

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(onTap: () {
          Navigator.pop(context);
        }),
        Text('Đăng ký ngay', style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
