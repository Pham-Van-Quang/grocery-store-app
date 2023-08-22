import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_store_app/common/back_arrow.dart';
import 'package:grocery_store_app/common/button_custom.dart';
import 'package:grocery_store_app/common/component.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:grocery_store_app/router/app_routers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({
    super.key,
    this.productData,
    this.currentAddress,
  });

  final ProductData? productData;
  final String? currentAddress;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int quantity = 1;
  bool productVisible = true;
  String? name;
  String? type;
  String? imageUrl;
  double? price;
  String? currentAddress;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      setState(() {
        name = prefs!.getString('productName');
        type = prefs!.getString('productType');
        imageUrl = prefs!.getString('productImageUrl');
        final productPrice = prefs!.get('productPrice');
        if (productPrice is double) {
          price = productPrice;
        } else if (productPrice is int) {
          price = productPrice.toDouble();
        } else {}
        quantity = prefs!.getInt('quantity') ?? 1;
        currentAddress = prefs!.getString('currentAddress');
      });
    }
  }

  void updateProductInfo(ProductData updatedProduct) async {
    setState(() {
      name = updatedProduct.name;
      type = updatedProduct.type;
      imageUrl = updatedProduct.imageUrl;
      price = updatedProduct.price?.toDouble() ?? 0.0;
    });
    await prefs!.setString('productName', name ?? "");
    await prefs!.setString('productType', type ?? "");
    await prefs!.setString('productImageUrl', imageUrl ?? "");
    await prefs!.setDouble('productPrice', price ?? 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, top: 53.h, right: 20.w),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackArrow(onTap: () {
                Navigator.pushNamed(context, AppRouterName.homepage);
              }),
              Text('Giỏ hàng',
                  style: Theme.of(context).textTheme.displayMedium),
              SizedBox(
                width: 22.w,
                height: 18.h,
              )
            ],
          ),
          SizedBox(height: 54.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
            width: double.infinity,
            decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06), blurRadius: 20)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Địa chỉ giao hàng',
                        style: Theme.of(context).textTheme.titleLarge),
                    SizedBox(height: 13.h),
                    Text(currentAddress ?? "",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouterName.mapscreen);
                  },
                  child: SvgPicture.asset(
                    'assets/icons/next-arrow.svg',
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Visibility(
            visible: name != null &&
                type != null &&
                imageUrl != null &&
                price != null,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.06), blurRadius: 20)
                  ]),
              child: Row(
                children: [
                  SizedBox(
                    height: 72.h,
                    width: 72.h,
                    child: Image.network(
                      imageUrl ?? "",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(name ?? "",
                              style: Theme.of(context).textTheme.titleLarge),
                          Text((type ?? ""),
                              style: Theme.of(context).textTheme.bodyLarge),
                          Text(
                              '$quantity x ${price?.toStringAsFixed(2) ?? ''} VNĐ',
                              style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await prefs?.remove('productName');
                          await prefs?.remove('productType');
                          await prefs?.remove('productImageUrl');
                          await prefs?.remove('productPrice');
                          await prefs?.remove('quantity');
                          setState(() {
                            productVisible = false;
                            name = null;
                            type = null;
                            imageUrl = null;
                            price = null;
                            quantity = 1;
                          });
                        },
                        child: SizedBox(
                          height: 18.h,
                          width: 18.h,
                          child: Center(
                              child:
                                  SvgPicture.asset('assets/icons/removes.svg')),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        height: 24.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: kPrimaryColor),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity >= 1) {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                                prefs!.setInt('quantity', quantity);
                              },
                              child: SizedBox(
                                  height: 10.h,
                                  child: SvgPicture.asset(
                                      'assets/icons/decrease.svg')),
                            ),
                            Text(quantity.toString(),
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                                prefs!.setInt('quantity', quantity);
                              },
                              child: SizedBox(
                                  height: 10.h,
                                  child: SvgPicture.asset(
                                      'assets/icons/increase.svg')),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tổng tiền: ', style: Theme.of(context).textTheme.titleLarge),
            Text('${(price ?? 0) * quantity} VNĐ',
                style: Theme.of(context).textTheme.titleLarge),
          ]),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.h, top: 30.h),
            child: Column(
              children: [
                CustomButton(
                  onPressed: () async {
                    if (widget.productData != null) {
                      updateProductInfo(widget.productData!);
                    }
                    await prefs!.setString(
                        'currentAddress', widget.currentAddress ?? "");
                  },
                  text: 'Lưu',
                ),
                SizedBox(height: 12.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.successfulorder);
                  },
                  text: 'Đặt hàng',
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
