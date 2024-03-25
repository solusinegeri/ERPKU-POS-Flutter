import 'package:erpku_pos/core/service/database_helper_history_payment_product.dart';
import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/home/data/entities/product_item_data_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/components/spaces.dart';
import '../../../../home/data/entities/order_item.dart';
import '../../../../home/data/entities/save_order_data_model.dart';
import '../../../../home/widgets/order_menu.dart';
import '../../../widgets/order_menu.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => _HistoryOrderPageState();
}

class _HistoryOrderPageState extends State<HistoryOrderPage> {

  final TextEditingController _searchController = TextEditingController();
  List<OrderSaveData> _orderList = [];
  String _searchValue = '';

  @override
  void initState() {
    super.initState();
    _fetchData();

  }

  Future<void> _fetchData() async {
    List<OrderSaveData> orders = await DatabaseHelperHistoryPaymentProduct.getHistoryOrder();
    setState(() {
      _orderList = orders;
      for (OrderSaveData order in orders) {
        print(order.toJson());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Flexible(
          child: ListView.builder(
            itemCount: _orderList.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order #${_orderList[index].id.toString()}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorValues.primary
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, innerinIndex) {
                      return OrderMenuHistory(
                        data: _orderList[index].orderItems[innerinIndex],
                        orderPayment: _orderList[index].orderNominal.toString(),
                        qty: _orderList[index].orderItems[innerinIndex].quantity.toString(),
                      );
                    },
                    itemCount: _orderList[index].orderItems.length,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
