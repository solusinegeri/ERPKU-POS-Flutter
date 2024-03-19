import 'package:erpku_pos/feature/order/presentation/history_order_page.dart';
import 'package:erpku_pos/feature/order/presentation/item/save_order_page/save_order_page.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/color_values.dart';
import '../../../../../core/widgets/components/spaces.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // LEFT CONTENT
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Order Page',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: const Icon(Icons.bookmark_border, color: ColorValues.primary,),
                    title: const Text('Daftar Pesanan'),
                    subtitle: const Text('Daftar Pesanan yang disimpan'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 0
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: const Icon(Icons.history_edu_rounded, color: ColorValues.primary,),
                    title: const Text('Riwayat Pesanan'),
                    subtitle: const Text('Riwayat Pesanan yang sudah dibayar'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 1
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(1),
                  ),
                ],
              ),
            ),
          ),

          // RIGHT CONTENT
          Expanded(
            flex: 4,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: IndexedStack(
                  index: currentIndex,
                  children: const [
                    SaveOrderPage(),
                    HistoryOrderPage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
