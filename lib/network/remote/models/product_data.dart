// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetProductListItemResponse {
  final List<ProductData> productListItem;
  final int responseCode;
  GetProductListItemResponse({
    required this.productListItem,
    required this.responseCode,
  });
}

class ProductData {
  final String? name;
  final int? price;
  final String? desciption;
  final String? imageUrl;
  final String? unit;
  final String? type;

  ProductData({
    required this.name,
    required this.price,
    required this.desciption,
    required this.imageUrl,
    required this.unit,
    required this.type,
  });

  get quantity => null;

  ProductData copyWith({
    String? name,
    int? price,
    String? desciption,
    String? imageUrl,
    String? unit,
  }) =>
      ProductData(
        name: name ?? this.name,
        price: price ?? this.price,
        desciption: desciption ?? this.desciption,
        imageUrl: imageUrl ?? this.imageUrl,
        unit: unit ?? this.unit,
        type: type ?? this.type,
      );

  factory ProductData.fromRawJson(String str) =>
      ProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        name: json["name"],
        price: json["price"],
        desciption: json["desciption"],
        imageUrl: json["imageUrl"],
        unit: json["unit"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "desciption": desciption,
        "imageUrl": imageUrl,
        "unit": unit,
        "type": type,
      };
}
