import 'order_item.dart';

class OrderSaveData {
  final int? id;
  final String? OrderName;
  final OrderItem? orderItem;

  const OrderSaveData({
    this.id,
    this.OrderName,
    this.orderItem,
  });

  factory OrderSaveData.fromJson(Map<String, dynamic> json) {
    return OrderSaveData(
      id: json['id'],
      OrderName: json['OrderName'],
      orderItem: OrderItem.fromJson(json['orderItem']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'OrderName': OrderName,
      'orderItem': orderItem?.toJson(), // Convert OrderItem to JSON
    };
  }
}
