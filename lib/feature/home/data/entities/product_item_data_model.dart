import 'package:erpku_pos/feature/home/data/entities/product_model.dart';

class ProductItemData {
  final int? id;
  final List<ProductModel> productItems;

  ProductItemData({
    this.id,
    required this.productItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productItems': productItems.map((item) => item.toJson()).toList()
    };
  }

  factory ProductItemData.fromJson(Map<String, dynamic> json) {
    return ProductItemData(
      id: json['id'],
      productItems: json['productItems'] != null
          ? (json['productItems'] as List<dynamic>).map((itemJson) => ProductModel.fromJson(itemJson)).toList()
          : [],
    );
  }
}