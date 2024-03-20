import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../feature/home/data/entities/save_order_data_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "ProductSaved.db";
  static DatabaseHelper? _instance; // Tambahkan atribut instance

  // Tambahkan constructor private
  DatabaseHelper._privateConstructor();

  // Getter untuk instance
  static DatabaseHelper get instance {
    // Jika instance belum ada, buat instance baru
    _instance ??= DatabaseHelper._privateConstructor();
    return _instance!;
  }

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

  static Future<List<OrderSaveData>> searchOrderByName(String name) async {
    final Database db = await _getDb(); // Menggunakan _getDb() untuk mendapatkan instance Database
    final List<Map<String, dynamic>> maps = await db.query(
      'productSave', // Ubah 'order' menjadi 'productSave' sesuai dengan nama tabel yang benar
      where: 'orderName LIKE ?', // Ganti 'name' menjadi 'orderName' sesuai dengan kolom yang benar
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return OrderSaveData(
        id: maps[i]['id'],
        orderName: maps[i]['orderName'],
        orderItems: [], // Ganti 'name' menjadi 'orderName' sesuai dengan kolom yang benar
        // Tambahkan pemetaan atribut lain dari database sesuai kebutuhan
      );
    });
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