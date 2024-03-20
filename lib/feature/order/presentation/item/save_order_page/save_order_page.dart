import 'package:erpku_pos/feature/home/widgets/empty_product.dart';
import 'package:flutter/material.dart';

import '../../../../../core/service/database_helper_save_product.dart';
import '../../../../../core/widgets/components/search_input.dart';
import '../../../../../core/widgets/components/spaces.dart';
import '../../../../home/data/entities/save_order_data_model.dart';
import '../../../widgets/card_save_order.dart';
import 'detail_save_order_page.dart';

class SaveOrderPage extends StatefulWidget {
  const SaveOrderPage({super.key});

  @override
  State<SaveOrderPage> createState() => _SaveOrderPageState();
}

class _SaveOrderPageState extends State<SaveOrderPage> {

  final TextEditingController _searchController = TextEditingController();
  List<OrderSaveData> _orderList = [];
  String _searchValue = '';

  @override
  void initState() {
    super.initState();
    _fetchData();

  }

  Future<void> _fetchData() async {
    List<OrderSaveData> orders = await DatabaseHelperSaveProduct.getOrder();
    setState(() {
      _orderList = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Flexible(
              child: SizedBox(
                child: SearchInput(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchValue = value; // Simpan nilai pencarian ke dalam _searchValue
                    });
                  },
                  hintText: 'Cari Nama Pemesan',
                ),
              ),
            ),
          ),
          const SpaceHeight(16.0),
          Flexible(
            flex: 12,
            child: FutureBuilder<List<OrderSaveData>>(
              future: _searchValue.isEmpty
                  ? DatabaseHelperSaveProduct.getOrder()
                  : DatabaseHelperSaveProduct.searchOrderByName(_searchValue),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<OrderSaveData> _orderList = snapshot.data ?? [];

                  if (_orderList.isEmpty) {
                    return const IsEmpty();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _orderList.length,
                    itemBuilder: (context, index) {
                      return CardSaveOrder(
                        orderName: _orderList[index].orderName ?? '',
                        orderNumber: index + 1,
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailSaveOrderPage(
                                orderNumber: index + 1,
                                orderSaveData: _orderList[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
