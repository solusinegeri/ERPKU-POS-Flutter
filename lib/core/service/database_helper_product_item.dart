import 'package:erpku_pos/feature/home/data/entities/product_item_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../feature/home/data/entities/product_category.dart';
import '../../feature/home/data/entities/product_model.dart';

class DatabaseHelperProductItem {
  static const int _version = 2; // Updated version number
  static const String _dbName = "ProductItem.db";
  static DatabaseHelperProductItem? _instance;

  DatabaseHelperProductItem._privateConstructor();

  static DatabaseHelperProductItem get instance {
    _instance ??= DatabaseHelperProductItem._privateConstructor();
    return _instance!;
  }

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE productItem("
              "id INTEGER PRIMARY KEY,"
              "image TEXT,"
              "name TEXT,"
              "category TEXT,"
              "price INTEGER,"
              "stock INTEGER"
              ")",
        );
      },
      version: _version,
    );
  }

  static Future<int> insertOrder(ProductItemData productItemData) async {
    final Database db = await _getDb();

    // Extract individual product attributes
    final List<ProductModel> products = productItemData.productItems;

    // Insert each product into the database
    int totalInserted = 0;
    for (final product in products) {
      int result = await db.insert(
        'productItem',
        {
          'image': product.image,
          'name': product.name,
          'category': product.category.toValue(),
          'price': product.price,
          'stock': product.stock,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      totalInserted += result;
    }

    // Return the number of inserted products
    return totalInserted;
  }

  static Future<int> updateOrder(ProductItemData productItemData) async {
    final Database db = await _getDb();
    return await db.update(
      'productItem',
      productItemData.toJson(),
      where: 'id = ?',
      whereArgs: [productItemData.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteOrder(ProductItemData productItemData) async {
    final Database db = await _getDb();
    return await db.delete(
      'productItem',
      where: 'id = ?',
      whereArgs: [productItemData.id],
    );
  }

  static Future<List<ProductItemData>> getOrder() async {
    final Database db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('productItem');

    // Convert database query results to ProductItemData list
    return List.generate(maps.length, (i) {
      return ProductItemData(
        id: maps[i]['id'],
        productItems: [
          ProductModel(
            image: maps[i]['image'],
            name: maps[i]['name'],
            category: ProductCategory.fromValue(maps[i]['category']),
            price: maps[i]['price'],
            stock: maps[i]['stock'],
          ),
        ],
      );
    });
  }
}
