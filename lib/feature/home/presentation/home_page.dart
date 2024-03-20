import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/home/data/entities/save_order_data_model.dart';
import 'package:erpku_pos/feature/home/widgets/empty_product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/service/database_helper_product_item.dart';
import '../../../core/service/database_helper_save_product.dart';
import '../../../core/widgets/components/buttons.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../payment/presentation/confirm_payment_page.dart';
import '../data/entities/order_item.dart';
import '../data/entities/product_category.dart';
import '../data/entities/product_item_data_model.dart';
import '../data/entities/product_model.dart';
import '../widgets/column_button.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/home_title.dart';
import '../widgets/order_menu.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.orderSaveData});
  final OrderSaveData? orderSaveData;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final TextEditingController   nameController = TextEditingController();

  List<ProductModel> searchResults = [];
  List<ProductModel> products = []; // Initialize empty list initially

  final Map<ProductModel, int> selectedProducts = {};
  int quantity = 0;

  @override
  void initState() {
    // Call the method to fetch products from the database
    _fetchProductsFromDatabase();
    super.initState();
  }

  // Method to fetch products from the database
  Future<void> _fetchProductsFromDatabase() async {
    try {
      // Fetch products from the database using appropriate method
      List<ProductItemData> productItems = await DatabaseHelperProductItem.getOrder();

      // Flatten the list of product items into a single list of products
      products = productItems
          .expand((item) => item.productItems)
          .toList();

      // Update the UI with the fetched products
      setState(() {
        searchResults = products;
      });
    } catch (e) {
      print('Error fetching products from database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const IsEmpty();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HomeTitle(
                            controller: searchController,
                            onChanged: (value) {
                              searchResults = products
                                  .where((e) => e.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                                  .toList();
                              setState(() {});
                            },
                          ),
                          const SizedBox(height: 24),
                          CustomTabBar(
                            tabTitles: const [
                              'Semua',
                              'Makanan',
                              'Minuman',
                              'Snack'
                            ],
                            initialTabIndex: 0,
                            tabViews: [
                              if (searchResults.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 80.0),
                                  child: IsEmpty(),
                                )
                              else
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchResults.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.85,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 30.0,
                                    ),
                                    itemBuilder: (context, index) => ProductCard(
                                      data: searchResults[index],
                                      onCartButton: () {
                                        _toggleProductSelection(
                                            searchResults[index]);
                                      },
                                      qty: selectedProducts
                                          .containsKey(searchResults[index])
                                          ? selectedProducts[
                                      searchResults[index]] ??
                                          0
                                          : 0,
                                    ),
                                  ),
                                ),
                              if (searchResults
                                  .where((element) => element.category.isFood)
                                  .toList()
                                  .isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 80.0),
                                  child: IsEmpty(),
                                )
                              else
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchResults
                                        .where((element) => element.category.isFood)
                                        .toList()
                                        .length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.85,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 30.0,
                                    ),
                                    itemBuilder: (context, index) => ProductCard(
                                      data: searchResults
                                          .where(
                                              (element) => element.category.isFood)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(
                                            searchResults[index]);
                                      },
                                      qty: selectedProducts
                                          .containsKey(searchResults[index])
                                          ? selectedProducts[
                                      searchResults[index]] ??
                                          0
                                          : 0,
                                    ),
                                  ),
                                ),
                              if (searchResults
                                  .where((element) => element.category.isDrink)
                                  .toList()
                                  .isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 80.0),
                                  child: IsEmpty(),
                                )
                              else
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchResults
                                        .where(
                                            (element) => element.category.isDrink)
                                        .toList()
                                        .length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.85,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 30.0,
                                    ),
                                    itemBuilder: (context, index) => ProductCard(
                                      data: searchResults
                                          .where(
                                              (element) => element.category.isDrink)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(
                                            searchResults[index]);
                                      },
                                      qty: selectedProducts
                                          .containsKey(searchResults[index])
                                          ? selectedProducts[
                                      searchResults[index]] ??
                                          0
                                          : 0,
                                    ),
                                  ),
                                ),
                              if (searchResults
                                  .where((element) => element.category.isSnack)
                                  .toList()
                                  .isEmpty)
                                const Padding(
                                  padding: EdgeInsets.only(top: 80.0),
                                  child: IsEmpty(),
                                )
                              else
                                SizedBox(
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: searchResults
                                        .where(
                                            (element) => element.category.isSnack)
                                        .toList()
                                        .length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.85,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 30.0,
                                      mainAxisSpacing: 30.0,
                                    ),
                                    itemBuilder: (context, index) => ProductCard(
                                      data: searchResults
                                          .where(
                                              (element) => element.category.isSnack)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(
                                            searchResults[index]);
                                      },
                                      qty: selectedProducts
                                          .containsKey(searchResults[index])
                                          ? selectedProducts[
                                      searchResults[index]] ??
                                          0
                                          : 0,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Orders #1',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SpaceHeight(8.0),
                        Row(
                          children: [
                            Button.filled(
                              width: 120.0,
                              height: 40,
                              onPressed: () {},
                              label: 'Dine In',
                            ),
                          ],
                        ),
                        const SpaceHeight(16.0),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Item',
                              style: TextStyle(
                                color: ColorValues.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            SizedBox(
                              width: 50.0,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                  color: ColorValues.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: ColorValues.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(8),
                        const Divider(),
                        const SpaceHeight(8),
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
                              final entry =
                                  selectedProducts.entries.toList()[index];
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
                        const SpaceHeight(8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColumnButton(
                              label: 'Diskon',
                              svgGenImage: Assets.icons.diskon,
                              onPressed: () {},
                            ),
                            ColumnButton(
                              label: 'Pajak',
                              svgGenImage: Assets.icons.pajak,
                              onPressed: () {},
                            ),
                            ColumnButton(
                              label: 'Layanan',
                              svgGenImage: Assets.icons.layanan,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SpaceHeight(8.0),
                        const Divider(),
                        const SpaceHeight(8.0),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sub total',
                              style: TextStyle(color: ColorValues.grey),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID', symbol: 'Rp')
                                  .format(
                                selectedProducts.entries.fold(
                                    0,
                                    (previousValue, element) =>
                                        previousValue +
                                        (element.key.price * element.value)),
                              ),
                              style: const TextStyle(
                                color: ColorValues.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SpaceHeight(100.0),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Button.outlined(
                              width: 200,
                              onPressed: () {
                                // dialog text field untuk input nama pemesan
                                showDialog(
                                  context: context,
                                  builder: (BuildContext contextt) {
                                    return AlertDialog(
                                      title: const Text('Nama Pemesan'),
                                      content: TextField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          hintText: 'Masukkan nama pemesan',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(contextt);
                                          },
                                          child: const Text('Batal'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final name = nameController.text;
                                            print('Name: $name');

                                            if (name.isNotEmpty && selectedProducts.isNotEmpty) {
                                              _saveOrderData(name, _convertToOrderItems(selectedProducts));
                                            } else {
                                              if (name.isEmpty) {
                                                print('Nama is null');
                                              }
                                              if (selectedProducts.isEmpty) {
                                                print('Anda belum memilih produk.');
                                              }
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('Simpan'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              label: 'Simpan',
                            ),
                          ),
                          const SpaceWidth(8.0),
                          Flexible(
                            child: Button.filled(
                              width: 200,
                              onPressed: () {
                                _navigateToConfirmPaymentPage();
                              },
                              label: 'Pembayaran',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _toggleProductSelection(ProductModel product) {
    bool isProductSelected = selectedProducts.containsKey(product);

    if (isProductSelected) {
      selectedProducts[product] = (selectedProducts[product] ?? 0) + 1;
    } else {
      selectedProducts[product] = 1;
    }
    // Perbarui state di HomePage dengan mengatur ulang selectedProducts
    setState(() {});
  }

  void _navigateToConfirmPaymentPage() {
    List<OrderItem> selectedProductsList =
        selectedProducts.entries.map((entry) {
      return OrderItem(product: entry.key, quantity: entry.value);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ConfirmPaymentPage(selectedProducts: selectedProductsList),
      ),
    );
  }

  List<OrderItem> _convertToOrderItems(Map<ProductModel, int> selectedProducts) {
    return selectedProducts.entries.map((entry) {
      return OrderItem(product: entry.key, quantity: entry.value);
    }).toList();
  }

  void _saveOrderData(String name, List<OrderItem> orderItems) async {
    if (name.isNotEmpty && orderItems.isNotEmpty) {
      final OrderSaveData orderSaveData = OrderSaveData(
        id: widget.orderSaveData?.id,
        orderName: name,
        orderItems: orderItems,
      );

      int result = await DatabaseHelperSaveProduct.insertOrder(orderSaveData);

      if (result != 0) {
        print('Data berhasil dimasukkan ke dalam database!');
        List<OrderSaveData> allOrders = await DatabaseHelperSaveProduct.getOrder();
        print('Semua pesanan dalam database:');
        for (OrderSaveData order in allOrders) {
          print(order.toJson());
        }
      } else {
        print('Gagal memasukkan data ke dalam database.');
      }

      Navigator.pop(context);
    } else {
      if (name.isEmpty) {
        print('Nama is null');
      }
      if (orderItems.isEmpty) {
        print('Anda belum memilih produk.');
      }
      Navigator.pop(context);
    }
  }


}
