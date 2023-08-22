import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/component.dart';

class CustomBox extends GestureDetector {
  CustomBox({super.key, Function()? onTap, child, text})
      : super(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.only(top: 13.h, bottom: 13.h, left: 22.w),
              height: 50.sp,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kThirdColor, width: 1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child,
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(text,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: kTextColor))
                ],
              ),
            ));
}
