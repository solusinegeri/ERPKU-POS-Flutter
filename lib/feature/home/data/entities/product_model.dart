import 'package:erpku_pos/core/extensions/int_ext.dart';

import 'product_category.dart';

class ProductModel {
  final String image;
  final String name;
  final ProductCategory category;
  final int price;
  final int stock;
  final int quantity;

  ProductModel({
    required this.image,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.quantity = 0,
  });

  String get priceFormat => price.currencyFormatRp;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json['image'],
      name: json['name'],
      category: ProductCategory.fromValue(json['category']),
      price: json['price'],
      stock: json['stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'category': category.toValue(), // Convert ProductCategory to value
      'price': price,
      'stock': stock,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductModel &&
      other.image == image &&
      other.name == name &&
      other.category == category &&
      other.price == price &&
      other.stock == stock;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      name.hashCode ^
      category.hashCode ^
      price.hashCode ^
      stock.hashCode;
  }
}
