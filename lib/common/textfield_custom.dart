import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/component.dart';

class TextfieldCustom extends SizedBox {
  TextfieldCustom(
      {super.key,
      Function()? onTap,
      hintText,
      controller,
      bool? obscureText,
      onSubmitted,
      onChanged,
      Widget? child_1,
      Widget? child_2})
      : super(
            height: 50.h,
            width: double.infinity,
            child: TextField(
              controller: controller,
              obscureText: obscureText ?? false,
              onSubmitted: onSubmitted,
              onTap: onTap,
              onChanged: onChanged,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: 16.sp,
                      color: kThirdColor,
                      fontWeight: FontWeight.normal),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 22.w),
                  suffixIcon: SizedBox(
                    width: 22.w,
                    child: Center(child: child_2),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(width: 1, color: kThirdColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(width: 1, color: kPrimaryColor))),
            ));
}
