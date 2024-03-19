import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/assets/assets.gen.dart';
import '../../../../home/data/entities/order_item.dart';
import '../../../../home/data/entities/product_category.dart';
import '../../../../home/data/entities/product_model.dart';
import '../../../../home/widgets/empty_product.dart';
import '../../../../home/widgets/order_menu.dart';

class DetailSaveOrderPage extends StatefulWidget {
  const DetailSaveOrderPage({super.key, required this.orderNumber});

  final int orderNumber;

  @override
  State<DetailSaveOrderPage> createState() => _DetailSaveOrderPageState();
}

class _DetailSaveOrderPageState extends State<DetailSaveOrderPage> {
  Map<ProductModel, int> selectedProducts = {
    ProductModel(
        image: Assets.images.menu1.path,
        name: 'Express Bowl Ayam Rica',
        category: ProductCategory.food,
        price: 32000,
        stock: 10): 1,
    ProductModel(
        image: Assets.images.menu2.path,
        name: 'Crispy Black Pepper Sauce',
        category: ProductCategory.food,
        price: 36000,
        stock: 10): 1,
    ProductModel(
        image: Assets.images.menu3.path,
        name: 'Mie Ayam Teriyaki',
        category: ProductCategory.food,
        price: 33000,
        stock: 10): 1,
  };
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 1000 ?
    Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // Force landscape mode
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);
          }
          return const Center(
            child: Text(
              'App Khusus Screen (Tablet Version dan mode landscape) ganti resolusi anda.',
              style: TextStyle(fontSize: 32),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    ) :SafeArea(
      child:  Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Detail Pesanan',
            style: TextStyle(
              color: ColorValues.primary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorValues.primary,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Item',
                  style: TextStyle(
                    color: ColorValues.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SpaceHeight(16.0),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: ColorValues.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "#${widget.orderNumber}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nama Pemesan',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Jhone Doe",
                          style: TextStyle(
                            color: ColorValues.subtitle,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selectedProducts.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 80.0),
                        child: IsEmpty(),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final entry = selectedProducts.entries.toList()[index];
                          return OrderMenu(
                            data: OrderItem(
                              product: entry.key,
                              quantity: entry.value,
                            ),
                            onIncrement: () {
                              selectedProducts[entry.key] =
                                  (selectedProducts[entry.key] ?? 0) + 1;
                              setState(() {});
                            },
                            onDecrement: () {
                              if (selectedProducts[entry.key] == 1) {
                                selectedProducts.remove(entry.key);
                              } else {
                                selectedProducts[entry.key] =
                                    (selectedProducts[entry.key] ?? 0) - 1;
                              }
                              setState(() {});
                            },
                            delete: () {
                              selectedProducts.remove(entry.key);
                              setState(() {});
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                        const SpaceHeight(1.0),
                        itemCount: selectedProducts.length,
                      ),
                  ],
                ),
                const SpaceHeight(16.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pajak',
                      style: TextStyle(color: ColorValues.grey),
                    ),
                    Text(
                      '11 %',
                      style: TextStyle(
                        color: ColorValues.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(8.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diskon',
                      style: TextStyle(color: ColorValues.grey),
                    ),
                    Text(
                      'Rp. 0',
                      style: TextStyle(
                        color: ColorValues.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(8.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sub total',
                      style: TextStyle(color: ColorValues.grey),
                    ),
                    Text(
                      'Rp. 100.000',
                      style: TextStyle(
                        color: ColorValues.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(24.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SpaceWidth(8.0),
                      Flexible(
                        child: Button.filled(
                          onPressed: () {},
                          label: 'Pembayaran',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
