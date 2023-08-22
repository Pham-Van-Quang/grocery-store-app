import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/component.dart';

class PersonalinforField extends Container {
  PersonalinforField({super.key, Function()? onTap,
      hintText,
      controller,
      onSubmitted,
      onChanged,
      Widget? child_1}) : super(
         height: 50.h,
         margin: EdgeInsets.only(bottom: 12.h),
            width: double.infinity,
            child: TextField(
              controller: controller,
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
                  prefixIcon: SizedBox(
                    width: 22.w,
                    child: Center(child: child_1),
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