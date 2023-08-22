import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/component.dart';

class ClickButton extends Container {
  ClickButton({super.key, Function()? onTap, text, icon})
      : super(
            height: 50.h,
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
            ),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
                color: const Color(0xff3AA756).withOpacity(0.15),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 23.w),
                    child: Text(text,
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: kTextColor,
                            fontWeight: FontWeight.normal)),
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: SvgPicture.asset('assets/icons/next-arrow.svg'),
                )
              ],
            ));
}
