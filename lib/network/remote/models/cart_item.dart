import 'dart:convert';

class CartItem {
  final String name;
  final String type;
  final String imageUrl;
  final String unit;
  final String description;
  final int id;
  final int price;

  CartItem({
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.unit,
    required this.description,
    required this.id,
    required this.price,
  });

  CartItem copyWith({
    String? name,
    String? type,
    String? imageUrl,
    String? unit,
    String? description,
    int? id,
    int? price,
    String? desciption,
  }) =>
      CartItem(
        name: name ?? this.name,
        type: type ?? this.type,
        imageUrl: imageUrl ?? this.imageUrl,
        unit: unit ?? this.unit,
        description: description ?? this.description,
        id: id ?? this.id,
        price: price ?? this.price,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "type": type,
      "imageUrl": imageUrl,
      "unit": unit,
      "description": description,
      "id": id,
      "price": price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) => CartItem(
        name: map["name"] as String,
        type: map["type"] as String,
        imageUrl: map["imageUrl"] as String,
        unit: map["unit"] as String,
        description: map["description"] as String,
        id: map["id"] as int,
        price: map["price"] as int,
      );

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);
}
