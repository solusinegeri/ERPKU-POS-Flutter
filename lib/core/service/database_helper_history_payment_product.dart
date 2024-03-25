import 'package:erpku_pos/feature/home/data/entities/order_item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../feature/home/data/entities/save_order_data_model.dart';

class DatabaseHelperHistoryPaymentProduct {
  static const int _version = 1;
  static const String _dbName = "ProductHistoryPayment.db";
  static DatabaseHelperHistoryPaymentProduct? _instance; // Tambahkan atribut instance

  // Tambahkan constructor private
  DatabaseHelperHistoryPaymentProduct._privateConstructor();

  // Getter untuk instance
  static DatabaseHelperHistoryPaymentProduct get instance {
    // Jika instance belum ada, buat instance baru
    _instance ??= DatabaseHelperHistoryPaymentProduct._privateConstructor();
    return _instance!;
  }

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE productHistoryPaymentOrder("
              "id INTEGER PRIMARY KEY,"
              "orderName TEXT NOT NULL,"
              "orderNominal TEXT NOT NULL,"
              "orderItems TEXT NOT NULL"
              ")",
        );
      },
      version: _version,
    );
  }

  static Future<int> insertHistoryOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.insert(
      'productHistoryPaymentOrder',
      orderSaveData.toJson(), // Convert OrderSaveData to JSON
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<OrderSaveData>> searchHistoryOrderByName(String name) async {
    final Database db = await _getDb(); // Menggunakan _getDb() untuk mendapatkan instance Database
    final List<Map<String, dynamic>> maps = await db.query(
      'productHistoryPaymentOrder', // Ubah 'order' menjadi 'productSave' sesuai dengan nama tabel yang benar
      where: 'orderName LIKE ?', // Ganti 'name' menjadi 'orderName' sesuai dengan kolom yang benar
      whereArgs: ['%$name%'],
    );

    return List.generate(maps.length, (i) {
      return OrderSaveData(
        id: maps[i]['id'],
        orderName: maps[i]['orderName'],
        orderNominal: maps[i]['orderNominal'],
        orderItems: [], // Ganti 'name' menjadi 'orderName' sesuai dengan kolom yang benar
        // Tambahkan pemetaan atribut lain dari database sesuai kebutuhan
      );
    });
  }


  static Future<int> updateHistoryOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.update(
      'productHistoryPaymentOrder',
      orderSaveData.toJson(),
      where: 'id = ?',
      whereArgs: [orderSaveData.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteHistoryOrder(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    return await db.delete(
      'productHistoryPaymentOrder',
      where: 'id = ?',
      whereArgs: [orderSaveData.id],
    );
  }

  static Future<List<OrderSaveData>> getHistoryOrder() async {
    final Database db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('productHistoryPaymentOrder');

    return List.generate(
      maps.length,
          (i) => OrderSaveData.fromJson(maps[i]),
    );
  }

}

