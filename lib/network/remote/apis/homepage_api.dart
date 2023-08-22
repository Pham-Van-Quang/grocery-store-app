import 'dart:convert';

import 'package:grocery_store_app/network/configs/network_constant.dart';
import 'package:grocery_store_app/network/remote/models/product_data.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  Future<GetProductListItemResponse> getProductListItem() async {
    var request = http.Request(
        'GET', Uri.parse('${NetworkConstant.baseUrl}/product_items.json'));
    http.StreamedResponse response = await request.send();
    {
      final data = await response.stream.bytesToString();
      final dataDecode = jsonDecode(data) as Map<String, dynamic>;

      List<ProductData> productList = [];
      List bannerList = [
        "assets/images/banner-1.jpg",
        "assets/images/banner-2.jpg"
      ];
      for (var item in dataDecode.entries) {
        final itemDecode = ProductData.fromJson(item.value);
        productList.add(itemDecode);
      }
      productList.shuffle();
      bannerList.shuffle();
      return GetProductListItemResponse(
          productListItem: productList, responseCode: response.statusCode);
    }
  }
}
