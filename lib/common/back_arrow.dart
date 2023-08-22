import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackArrow extends GestureDetector {
  BackArrow({super.key, Function()? onTap})
      : super(
            onTap: onTap,
            child: SizedBox(
                height: 18.h,
                width: 22.w,
                child: Center(
                    child: SvgPicture.asset('assets/icons/back-arrow.svg'))));
}
