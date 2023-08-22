import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/component.dart';

class ButtonAdd extends GestureDetector {
  ButtonAdd({super.key, Function()? onTap})
      : super(
            onTap: onTap,
            child: Container(
              height: 20.h,
              width: 20.h,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: SizedBox(
                  height: 10.h,
                  child:
                      Center(child: SvgPicture.asset('assets/icons/plus.svg'))),
            ));
}
