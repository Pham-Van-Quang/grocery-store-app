import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/common/textfield_custom.dart';
import 'package:grocery_store_app/views/forgotten_password/view_models/forgotten_password_cubit.dart';
import 'package:grocery_store_app/views/forgotten_password/view_models/forgotten_password_state.dart';

class ForgottenPassword extends StatefulWidget {
  const ForgottenPassword({super.key});

  @override
  State<ForgottenPassword> createState() => _ForgottenPasswordState();
}

class _ForgottenPasswordState extends State<ForgottenPassword> {
  late final _forgottenpasswordCubit = context.read<ForgottenPasswordCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenPasswordCubit, ForgottenPasswordState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
            child: Column(
              children: [
                const _ForgottenPasswordHeader(),
                SizedBox(height: 32.h),
                SizedBox(
                  height: 216,
                  child: Center(
                    child: SvgPicture.asset('assets/icons/image-3.svg'),
                  ),
                ),
                SizedBox(height: 60.h),
                TextfieldCustom(
                  controller: _forgottenpasswordCubit.email,
                  onTap: () => _forgottenpasswordCubit.isEmailFocused(),
                  onChanged: (value) =>
                      _forgottenpasswordCubit.isEmailFocused(),
                  hintText: 'Nhập email',
                ),
                SizedBox(height: 12.h),
                _ConfirmEmail(forgottenpasswordCubit: _forgottenpasswordCubit),
                SizedBox(height: 60.h),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Bạn không nhận được mã xác nhận ? ',
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 14.sp,
                          fontFamily: 'SVN-Avo')),
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: 'Gửi lại',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SVN-Avo'))
                ]))
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmEmail extends StatelessWidget {
  const _ConfirmEmail({
    required ForgottenPasswordCubit forgottenpasswordCubit,
  }) : _forgottenpasswordCubit = forgottenpasswordCubit;

  final ForgottenPasswordCubit _forgottenpasswordCubit;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: () {
        if (_forgottenpasswordCubit.email.text.isEmpty) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Vui lòng nhập địa chỉ email.'),
              );
            },
          );
        } else {
          bool isEmailValid = EmailValidator.validate(
              _forgottenpasswordCubit.email.text.trim());
          if (isEmailValid) {
            context
                .read<ForgottenPasswordCubit>()
                .resetPassword(_forgottenpasswordCubit.email.text.trim());
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text(
                    'Đường dẫn đặt lại mật khẩu đã được gửi. Kiểm tra email!',
                  ),
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  content: Text('Địa chỉ email không hợp lệ.'),
                );
              },
            );
          }
        }
      },
      text: 'Gửi',
    );
  }
}

class _ForgottenPasswordHeader extends StatelessWidget {
  const _ForgottenPasswordHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(),
        Text('Quên mật khẩu', style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
