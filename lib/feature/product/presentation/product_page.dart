import 'package:erpku_pos/feature/product/presentation/add_product_page.dart';
import 'package:erpku_pos/feature/product/presentation/list_product_page.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/color_values.dart';
import '../../../core/widgets/components/spaces.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;

  void indexValue(int index) {
    currentIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
                    'Product Page',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: const Icon(
                      Icons.add_box_outlined,
                      color: ColorValues.primary,
                    ),
                    title: const Text('Tambah Product'),
                    subtitle: const Text('Tambah Product Baru'),
                    textColor: ColorValues.primary,
                    tileColor: currentIndex == 0
                        ? ColorValues.blueLight
                        : Colors.transparent,
                    onTap: () => indexValue(0),
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: const Icon(
                      Icons.list_alt_outlined,
                      color: ColorValues.primary,
                    ),
                    title: const Text('List Product'),
                    subtitle: const Text('List Product yang sudah ada'),
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
                    AddProductPage(),
                    ListProductPage(),
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
