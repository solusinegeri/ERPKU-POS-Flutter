import 'package:erpku_pos/core/service/database_helper_history_payment_product.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/home/data/entities/history_order_data_model.dart';
import 'package:flutter/material.dart';
import '../../../../home/widgets/empty_product.dart';
import '../../../widgets/order_menu.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {

  List<HistoryOrderSaveData> _orderList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();

  }

  Future<void> _fetchData() async {
    List<HistoryOrderSaveData> orders = await DatabaseHelperHistoryPaymentProduct.getHistoryOrder();
    setState(() {
      _orderList = orders;
      for (HistoryOrderSaveData order in orders) {
        print(order.toJson());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_orderList.isEmpty) {
      return const IsEmpty();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _orderList.length,
                itemBuilder: (context, index) {
                  final reversedIndex = _orderList.length - index - 1;
                  final order = _orderList[reversedIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order.id.toString()}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorValues.primary,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, innerIndex) {
                          final innerItemIndex = order.orderItems.length - innerIndex - 1;
                          final orderItem = order.orderItems[innerItemIndex];
                          return OrderMenuHistory(
                            data: orderItem,
                            orderPayment: order.orderItems[innerItemIndex].product.price.toString(),
                            qty: orderItem.quantity.toString(),
                          );
                        },
                        itemCount: order.orderItems.length,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),

      ),
    );
  }
}
