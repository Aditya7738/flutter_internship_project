import 'dart:convert';

import 'package:Tiara_by_TJ/model/cart_product_model.dart';
import 'package:Tiara_by_TJ/model/layout_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  final databaseName = "tiara_by_tj.db";
  final tableName = "layout_design";

  final firstColumn = "id";
  final secondColumn = "layout_model";

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory =
        await getApplicationDocumentsDirectory(); //creating db in local storage
    String path = join(documentDirectory.path, databaseName); //path of db
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("DATABASE CREATED");
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE $tableName (
      $firstColumn INTEGER PRIMARY KEY,
       $secondColumn TEXT
      );''';

    await db.execute(sql);
    print("TABLE CREATED");
  }

  Future<void> insert(LayoutModel layoutModel) async {
    var client = await db;
    if (layoutModel.data != null) {
      String serializedData = jsonEncode(layoutModel.data);
      if (client != null) {
        int result = await client.rawInsert(
            "INSERT INTO $tableName ($firstColumn, $secondColumn)"
            " VALUES (?, ?)",
            [1, serializedData]);
        print("insert result $result");

        final List<Map<String, dynamic>> maps = await client.query(tableName);

        List<LayoutModel> layouts = List.generate(maps.length, (i) {
          return LayoutModel.fromJson(maps[i]);
        });

        print("$tableName table $layouts");
      } else {
        print("client != null ${client != null}");
        _db = await initDatabase();
        insert(layoutModel);
        // int result = await client!.rawInsert("INSERT INTO $tableName ($firstColumn, $secondColumn)"
        //         " VALUES (0, ${layoutModel.data})");
        // print("insert result $result");
      }
    } else {
      print("layoutModel.data != null ${layoutModel.data != null}");
    }
  }

  Future<void> readData() async {}

  Future<List<CartProductModel>> getCartList() async {
    var client = await db;
    final List<Map<String, Object?>> queryResult = await client!.query('cart');
    return queryResult.map((e) => CartProductModel.fromMap(e)).toList();
  }
}
