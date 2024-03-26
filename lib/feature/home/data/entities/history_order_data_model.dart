import 'dart:convert';

import 'order_item.dart';

class HistoryOrderSaveData {
  final int? id;
  final String? orderName;
  final String? orderNominal;
  final List<OrderItem> orderItems;

  HistoryOrderSaveData({
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

  factory HistoryOrderSaveData.fromJson(Map<String, dynamic> json) {
    return HistoryOrderSaveData(
      id: json['id'],
      orderName: json['orderName'],
      orderNominal: json['orderNominal'],
      orderItems: (jsonDecode(json['orderItems']) as List<dynamic>).map((itemJson) => OrderItem.fromJson(itemJson)).toList(),
    );
  }
}