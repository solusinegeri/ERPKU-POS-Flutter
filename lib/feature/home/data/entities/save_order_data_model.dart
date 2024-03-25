import 'dart:convert';

import 'order_item.dart';

class OrderSaveData {
  final int? id;
  final String? orderName;
  final String? orderNominal;
  final List<OrderItem> orderItems;

  OrderSaveData({
    this.id,
    this.orderName,
    this.orderNominal,
    required this.orderItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderName': orderName,
      'orderNominal': orderNominal,
      'orderItems': jsonEncode(orderItems.map((item) => item.toJson()).toList())
    };
  }

  factory OrderSaveData.fromJson(Map<String, dynamic> json) {
    return OrderSaveData(
      id: json['id'],
      orderName: json['orderName'],
      orderNominal: json['orderNominal'],
      orderItems: (jsonDecode(json['orderItems']) as List<dynamic>).map((itemJson) => OrderItem.fromJson(itemJson)).toList(),
    );
  }
}