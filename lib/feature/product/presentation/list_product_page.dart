import 'package:erpku_pos/feature/product/presentation/edit_product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/service/database_helper_product_item.dart';
import '../../home/data/entities/product_item_data_model.dart';
import '../../home/data/entities/product_model.dart';
import '../../home/widgets/custom_tab_bar.dart';
import '../../home/widgets/empty_product.dart';
import '../../home/widgets/product_card.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {

  List<ProductModel> searchResults = [];
  List<ProductModel> products = []; // Initialize empty list initially
  List<ProductItemData> productItems = [];

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
      productItems = await DatabaseHelperProductItem.getOrder();

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
              flex: 2,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditProductPage(productModel: searchResults[index], id: productItems[index].id ?? 0),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                searchResults[index].name,
                                              ),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        qty: searchResults[index].stock,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditProductPage(productModel: searchResults[index], id: productItems[index].id ?? 0),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                searchResults[index].name,
                                              ),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        qty: searchResults[index].stock,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditProductPage(productModel: searchResults[index], id: productItems[index].id ?? 0),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                searchResults[index].name,
                                              ),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        qty: searchResults[index].stock,
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditProductPage(productModel: searchResults[index], id: productItems[index].id ?? 0),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                searchResults[index].name,
                                              ),
                                              duration: const Duration(seconds: 2),
                                            ),
                                          );
                                        },
                                        qty: searchResults[index].stock,
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
          ],
        ),
      ),
    );
  }
}
