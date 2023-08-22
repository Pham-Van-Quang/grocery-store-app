import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/component.dart';

class CustomButton extends ElevatedButton {
  CustomButton({super.key, Function()? onPressed, text})
      : super(
            onPressed: onPressed,
            child: Text(text,
                style: TextStyle(
                    fontFamily: 'SVN-Avo',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50.h)));
}
