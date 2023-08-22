import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/router/app_routers.dart';

class SuccussfulOrder extends StatefulWidget {
  const SuccussfulOrder({super.key});

  @override
  State<SuccussfulOrder> createState() => _SuccussfulOrderState();
}

class _SuccussfulOrderState extends State<SuccussfulOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 175.h, 20.w, 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: SizedBox(
                    height: 233.h,
                    child: SvgPicture.asset('assets/icons/image-7.svg'))),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 92.h),
                child: Text(
                  'Đặt hàng thành công',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouterName.trackingorder);
              },
              text: 'Theo dõi shipper',
            )
          ],
        ),
      ),
    );
  }
}
