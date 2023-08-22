import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:grocery_store_app/views/cart/cart.dart';
import 'package:intl/intl.dart';

class ProductInfor extends StatefulWidget {
  const ProductInfor({super.key, this.productData});
  final ProductData? productData;

  @override
  State<ProductInfor> createState() => _ProductInforState();
}

class _ProductInforState extends State<ProductInfor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _ProductInforHeader(),
            Padding(
              padding: EdgeInsets.fromLTRB(48.w, 14.h, 48.w, 40.h),
              child: SizedBox(
                height: 246.h,
                width: 238.w,
                child: Image.network(widget.productData?.imageUrl ?? ""),
              ),
            ),
            Text(
              widget.productData?.name ?? "",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            SizedBox(height: 10.h),
            Text(
              widget.productData?.type ?? "",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: kThirdColor),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: NumberFormat("#,##0")
                          .format(widget.productData?.price),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColor)),
                  TextSpan(
                      text: " VNĐ/ ${widget.productData?.unit}",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontFamily: 'SVN-Avo',
                          fontWeight: FontWeight.normal,
                          color: kThirdColor)),
                ])),
              ],
            ),
            SizedBox(height: 30.h),
            Text('Về sản phẩm',
                style: Theme.of(context).textTheme.displaySmall),
            SizedBox(height: 14.h),
            Text(widget.productData?.desciption ?? "",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: kTextColor)),
            SizedBox(height: 26.h),
            CustomButton(
              onPressed: () {
                if (widget.productData != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cart(
                        productData: widget.productData,
                        currentAddress: '',
                      ),
                    ),
                  );
                }
              },
              text: 'Thêm vào giỏ hàng',
            )
          ],
        ),
      ),
    );
  }
}

class _ProductInforHeader extends StatelessWidget {
  const _ProductInforHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackArrow(onTap: () {
          Navigator.pop(context);
        }),
        Text('Chi tiết',
            style: Theme.of(context).textTheme.displayMedium),
        SizedBox(
          width: 22.w,
          height: 18.h,
        )
      ],
    );
  }
}
