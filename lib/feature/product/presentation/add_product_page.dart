import 'dart:io';

import 'package:erpku_pos/core/theme/color_values.dart';
import 'package:erpku_pos/core/widgets/components/components.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/service/database_helper_product_item.dart';
import '../../../core/utils/CurrencyInputFormatter.dart';
import '../../home/data/entities/product_category.dart';
import '../../home/data/entities/product_item_data_model.dart';
import '../../home/data/entities/product_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _stockController = TextEditingController();
  final CurrencyInputFormatter _currencyFormatter = CurrencyInputFormatter();

  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _getImage(ImageSource source, int imageIndex) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Halaman Tambah Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  const Text(
                    'Tambahkan produk baru untuk dijual',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SpaceHeight(24.0),
                  const Text(
                    'Foto Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(16.0),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheetPhoto(context);
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ColorValues.blueLight,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: _imageFile != null
                            ? Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(_imageFile!),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ColorValues.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: ColorValues.primary,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.camera_alt,
                                color: ColorValues.primary,
                                size: 40,
                              ),
                      ),
                    ),
                  ),
                  const SpaceHeight(24.0),
                  const Text(
                    'Nama Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  TextFormField(
                    controller: _productController,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Masukkan Nama Produk',
                    ),
                  ),
                  const SpaceHeight(24.0),
                  const Text(
                    'Harga Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [_currencyFormatter],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Masukkan Harga Produk',
                    ),
                  ),
                  const SpaceHeight(24.0),
                  const Text(
                    'Kategori Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  //dropdown textfield category
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Makanan',
                        child: Text('Makanan'),
                      ),
                      DropdownMenuItem(
                        value: 'Minuman',
                        child: Text('Minuman'),
                      ),
                      DropdownMenuItem(
                        value: 'Snack',
                        child: Text('Snack'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _categoryController.text = value.toString();
                      });
                    },
                    value: _categoryController.text.isEmpty
                        ? null
                        : _categoryController.text,
                    style: const TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SpaceHeight(24.0),
                  const Text(
                    'Stok Produk',
                    style: TextStyle(
                      color: ColorValues.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SpaceHeight(8.0),
                  TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'Masukkan Stok Produk',
                    ),
                  ),
                  const SpaceHeight(24.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ColoredBox(
                      color: ColorValues.white,
                      child: Button.filled(
                        onPressed: () {
                          //save product
                          _saveProduct();
                        },
                        label: 'Simpan',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showBottomSheetPhoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Pilih foto produk',
                style: TextStyle(
                  color: ColorValues.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SpaceHeight(24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _getImage(ImageSource.camera, 0);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: ColorValues.primary,
                          size: 40,
                        ),
                        SpaceHeight(8.0),
                        Text(
                          'Kamera',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _getImage(ImageSource.gallery, 0);
                      Navigator.pop(context);
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.photo,
                          color: ColorValues.primary,
                          size: 40,
                        ),
                        SpaceHeight(8.0),
                        Text(
                          'Galeri',
                          style: TextStyle(
                            color: ColorValues.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ProductCategory convertToProductCategory(String categoryString) {
    switch (categoryString.toLowerCase()) {
      case 'makanan':
        return ProductCategory.food;
      case 'minuman':
        return ProductCategory.drink;
      case 'snack':
        return ProductCategory.snack;
      default:
        throw Exception('Unknown product category: $categoryString');
    }
  }

  void _saveProduct() async {
    String productName = _productController.text;
    String productPrice = _priceController.text.replaceAll(RegExp(r'[^0-9]'), ''); // Hapus karakter non-numeric
    String productCategory = _categoryController.text;
    String productStock = _stockController.text;

    // Check if any of the fields is empty
    if (productName.isEmpty || productPrice.isEmpty || productCategory.isEmpty) {
      // Show an alert or toast message to inform the user
      return;
    }

    int? price = int.tryParse(productPrice);
    int? stock = int.tryParse(productStock);

    if (price == null) {
      // Handle invalid price format
      return;
    }

    ProductCategory category = convertToProductCategory(productCategory);

    // Create a product model
    ProductModel productModel = ProductModel(
      name: productName,
      price: price,
      category: category,
      image: _imageFile?.path ?? '',
      stock: stock ?? 0,
    );

    // Create a product item data
    ProductItemData productItemData = ProductItemData(productItems: [productModel]);

    try {
      // Insert the product item data into the database
      int result = await DatabaseHelperProductItem.insertOrder(productItemData);
      print('Result: $result');

      if (result != 0) {
        // Product inserted successfully
        // Show a success message or navigate to another screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product saved successfully')),
        );

        // Print the database
        _printDatabaseContents();
      } else {
        // Failed to insert product
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product')),
        );
      }
    } catch (e) {
      // Handle the exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }


  void _printDatabaseContents() async {
    try {
      List<ProductItemData> items = await DatabaseHelperProductItem.getOrder();
      for(ProductItemData productItemData in items){
        print(productItemData.toJson());
      }
    } catch (e) {
      print('Error fetching database contents: $e');
    }
  }

}
