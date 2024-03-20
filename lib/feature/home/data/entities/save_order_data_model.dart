import 'dart:convert';

import 'order_item.dart';

class OrderSaveData {
  final int? id;
  final String? orderName;
  final List<OrderItem> orderItems;

  OrderSaveData({
    this.id,
    this.orderName,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderName': orderName,
      'orderItems': jsonEncode(orderItems.map((item) => item.toJson()).toList())
    };
  }

  factory OrderSaveData.fromJson(Map<String, dynamic> json) {
    return OrderSaveData(
      id: json['id'],
      orderName: json['orderName'],
      orderItems: (jsonDecode(json['orderItems']) as List<dynamic>).map((itemJson) => OrderItem.fromJson(itemJson)).toList(),
    );
  }
}