import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/feature/home/data/entities/save_order_data_model.dart';
import 'package:erpku_pos/feature/home/widgets/empty_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/gen/assets/assets.gen.dart';
import '../../../core/service/database_helper_product_item.dart';
import '../../../core/service/database_helper_save_product.dart';
import '../../../core/widgets/components/buttons.dart';
import '../../../core/widgets/components/spaces.dart';
import '../../home/data/entities/order_item.dart';
import '../../home/data/entities/product_item_data_model.dart';
import '../../home/data/entities/product_model.dart';
import '../../home/widgets/column_button.dart';
import '../../home/widgets/custom_tab_bar.dart';
import '../../home/widgets/home_title.dart';
import '../../home/widgets/order_menu.dart';
import '../../home/widgets/product_card.dart';
import '../../payment/presentation/confirm_payment_page.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key, this.orderSaveData, required this.orderName, required this.selectedProducts, this.orderNumber});
  final OrderSaveData? orderSaveData;
  final String orderName;
  final List<OrderItem> selectedProducts;
  final int? orderNumber;

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final searchController = TextEditingController();

  List<ProductModel> searchResults = [];
  List<ProductModel> products = []; // Initialize empty list initially

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Pilih Produk',
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
                                        _toggleProductSelection(searchResults[index]);
                                      },
                                      qty: widget.selectedProducts
                                          .where((item) => item.product == searchResults[index])
                                          .fold<int>(
                                        0,
                                            (previousValue, item) => previousValue + item.quantity,
                                      ),
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
                                          .where((element) => element.category.isFood)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(searchResults[index]);
                                      },
                                      qty: widget.selectedProducts
                                          .where((item) => item.product == searchResults[index])
                                          .fold<int>(
                                        0,
                                            (previousValue, item) => previousValue + item.quantity,
                                      ),
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
                                          .where((element) => element.category.isDrink)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(searchResults[index]);
                                      },
                                      qty: widget.selectedProducts
                                          .where((item) => item.product == searchResults[index])
                                          .fold<int>(
                                        0,
                                            (previousValue, item) => previousValue + item.quantity,
                                      ),
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
                                    itemBuilder: (context, index) =>
                                        ProductCard(
                                      data: searchResults
                                          .where((element) => element.category.isSnack)
                                          .toList()[index],
                                      onCartButton: () {
                                        _toggleProductSelection(searchResults[index]);
                                      },
                                      qty: widget.selectedProducts
                                          .where((item) => item.product == searchResults[index])
                                          .fold<int>(
                                        0,
                                            (previousValue, item) => previousValue + item.quantity,
                                      ),
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
                        if (widget.selectedProducts.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: IsEmpty(),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return OrderMenu(
                                data: widget.selectedProducts[index],
                                onIncrement: () {
                                  widget.selectedProducts[index].quantity++;
                                  setState(() {});
                                },
                                onDecrement: () {
                                  if (widget.selectedProducts[index].quantity > 1) {
                                    widget.selectedProducts[index].quantity--;
                                  }else {
                                    widget.selectedProducts.removeAt(index);
                                  }
                                  setState(() {});
                                },
                                delete: () {
                                  widget.selectedProducts.removeAt(index);
                                  setState(() {});
                                },
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SpaceHeight(1.0),
                            itemCount: widget.selectedProducts.length,
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
                                locale: 'id_ID',
                                symbol: 'Rp',
                              ).format(
                                widget.selectedProducts.fold<double>(
                                  0,
                                      (previousValue, orderItem) => previousValue + (orderItem.product.price * orderItem.quantity),
                                ),
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
                        children: [
                          Expanded(
                            child: Button.filled(
                              onPressed: () {
                                Map<ProductModel, int> selectedProductsMap = { for (var item in widget.selectedProducts) item.product : item.quantity };

                                _saveOrderData(
                                    widget.orderName,
                                    _convertToOrderItems(selectedProductsMap)
                                );
                              },
                              label: 'Simpan Pesanan',
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
    final index = widget.selectedProducts.indexWhere((element) => element.product == product);
    if (index != -1) {
      widget.selectedProducts[index].quantity++;
    } else {
      widget.selectedProducts.add(OrderItem(product: product, quantity: 1));
    }
    setState(() {});
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

      int result = await DatabaseHelperSaveProduct.updateOrder(orderSaveData);

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
