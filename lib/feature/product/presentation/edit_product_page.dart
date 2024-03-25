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

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key, required this.productModel, required this.id});
  final ProductModel productModel;
  final int id;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _productController = TextEditingController();
  late TextEditingController _priceController = TextEditingController();
  late TextEditingController _categoryController = TextEditingController();
  late TextEditingController _stockController = TextEditingController();
  final CurrencyInputFormatter _currencyFormatter = CurrencyInputFormatter();

  ProductCategory? _selectedCategory;

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
  void initState() {
    super.initState();
    print(widget.id);
    _imageFile = widget.productModel.image.isNotEmpty ? File(widget.productModel.image) : null;
    _productController = TextEditingController(text: widget.productModel.name);
    _priceController = TextEditingController(text: widget.productModel.price.toString());
    _categoryController = TextEditingController(text: widget.productModel.category.value);
    _stockController = TextEditingController(text: widget.productModel.stock.toString());
    _selectedCategory = widget.productModel.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Halaman Edit dan Detail Produk',
                        style: TextStyle(
                          color: ColorValues.primary,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SpaceHeight(8.0),
                      const Text(
                        'Produk yang ada di toko anda',
                        style: TextStyle(
                          color: ColorValues.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          DatabaseHelperProductItem.deleteOrder(
                            ProductItemData(
                              id: widget.id,
                              productItems: [widget.productModel],
                            ),
                          );
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
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
                        child: _imageFile != null || widget.productModel.image.isNotEmpty
                            ? Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : FileImage(File(widget.productModel.image)),
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
                          Icons.add_a_photo,
                          color: ColorValues.primary,
                          size: 40,
                        )
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
                    items: ProductCategory.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value as ProductCategory;
                        _categoryController.text = _selectedCategory!.value;
                      });
                    },
                    value: _selectedCategory ?? widget.productModel.category,
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
                          _updateProduct();
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

  void _updateProduct() async {
    String productName = _productController.text;
    String productPrice = _priceController.text.replaceAll(RegExp(r'[^0-9]'), ''); // Hapus karakter non-numeric
    String productCategory = _categoryController.text;
    String productStock = _stockController.text;
    print(productName);

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
      image: _imageFile != null ? _imageFile!.path : '', // Ubah bagian ini
      stock: stock ?? 0,
    );

    print('Product Model: ${productModel.toJson()}');

    try {
      // Update the product in the database
      print(widget.id);
      int result = await DatabaseHelperProductItem.updateOrder(widget.id, productModel);
      print('Result: $result');

      if (result != 0) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Produk berhasil disimpan'), backgroundColor: Colors.green,),
        );

        _printDatabaseContents();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan produk'), backgroundColor: Colors.red,),
        );
      }
    } catch (e) {
      // Handle the exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red,),
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
