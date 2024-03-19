import 'dart:convert';

import 'package:erpku_pos/feature/home/data/entities/save_order_data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../feature/home/data/entities/order_item.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "ProductSaved.db";

  static Future<Database> _getDb() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
          return await db.execute("CREATE TABLE productSave(id INTEGER PRIMARY KEY, orderName TEXT NOT NULL, orderItem TEXT)");
        }, version: _version
    );
  }

  static Future<int> addSaveProducts(List<OrderSaveData> orderSaveDataList) async {
    final Database db = await _getDb();
    final Batch batch = db.batch();

    for (final orderSaveData in orderSaveDataList) {
      batch.insert(
        'productSave',
        orderSaveData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    try {
      final List<dynamic> results = await batch.commit();
      print('Data berhasil ditambahkan ke database');
      return results.length; // Return the count of inserted rows
    } catch (e) {
      print('Error adding data to database: $e');
      return 0; // Return 0 if there's an error
    }
  }



  static Future<int> updateSaveProduct(OrderSaveData orderSaveData) async {
    final Database db = await _getDb();
    final List<Map<String, dynamic>> result = await db.query(
      'productSave',
      where: 'id = ?',
      whereArgs: [orderSaveData.id],
    );

    if (result.isNotEmpty) {
      return await db.update(
        'productSave',
        orderSaveData.toJson(),
        where: 'id = ?',
        whereArgs: [orderSaveData.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      return await db.insert(
        'productSave',
        orderSaveData.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<List<OrderSaveData>> getSaveProduct() async {
    final Database db = await _getDb();
    try {
      final List<Map<String, dynamic>> maps = await db.query('productSave');
      print('Total records in database: ${maps.length}');

      List<OrderSaveData> orderSaveDataList = [];

      for (var map in maps) {
        try {
          String jsonString = map['orderItem']?.trim() ?? '';
          print('JSON string before parsing: $jsonString'); // Debug output
          if (jsonString.isNotEmpty) {
            dynamic decodedJson = json.decode(jsonString);
            OrderSaveData orderSaveData = OrderSaveData(
              id: map['id'],
              OrderName: map['orderName'], // Correct the key to 'orderName'
              orderItem: OrderItem.fromJson(Map<String, dynamic>.from(decodedJson['product'])), // Parse JSON back into OrderItem
            );
            orderSaveDataList.add(orderSaveData);
          }
        } catch (e) {
          print('Error parsing JSON: $e');
          print('JSON string causing the error: ${map['orderItem']}');
        }
      }

      print('Successfully parsed ${orderSaveDataList.length} records');
      return orderSaveDataList;
    } catch (e) {
      print('Error fetching data from database: $e');
      return [];
    }
  }


}