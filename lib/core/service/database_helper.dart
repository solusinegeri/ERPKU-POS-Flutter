import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../feature/home/data/entities/save_order_data_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "ProductSaved.db";

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE productSave("
              "id INTEGER PRIMARY KEY,"
              "orderName TEXT NOT NULL,"
              "orderItems TEXT NOT NULL"
              ")",
        );
      },
      version: _version,
    );
  }

  static Future<int> insertOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.insert(
      'productSave',
      orderSaveData.toJson(), // Convert OrderSaveData to JSON
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.update(
      'productSave',
      orderSaveData.toJson(),
      where: 'id = ?',
      whereArgs: [orderSaveData.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.delete(
      'productSave',
      where: 'id = ?',
      whereArgs: [orderSaveData.id],
    );
  }

  static Future<List<OrderSaveData>> getOrder() async {
    final Database db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('productSave');

    return List.generate(
      maps.length,
          (i) => OrderSaveData.fromJson(maps[i]),
    );
  }
}