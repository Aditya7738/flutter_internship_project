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

    if (client != null) {
      String serializedData = jsonEncode(layoutModel);

      print("serializedData ${serializedData}");

      List<Map<String, dynamic>> existingRows = await client.query(
        tableName,
        where: '$firstColumn = ?',
        whereArgs: [1],
      );

      if (existingRows.isEmpty) {
        int result = await client.rawInsert(
            "INSERT INTO $tableName ($firstColumn, $secondColumn)"
            " VALUES (?, ?)",
            [1, serializedData]);
        print("insert result $result");
      } else {
        updateTable(layoutModel);
      }

      final List<Map<String, dynamic>> maps = await client.query(tableName);

      List<LayoutModel> layouts = List.generate(maps.length, (i) {
        return LayoutModel.fromJson(maps[i]);
      });

      print("$tableName table $layouts");
    } else {
      print("client != null ${client != null}");
      _db = await initDatabase();
      await insert(layoutModel);
      // int result = await client!.rawInsert("INSERT INTO $tableName ($firstColumn, $secondColumn)"
      //         " VALUES (0, ${layoutModel.data})");
      // print("insert result $result");
    }
  }

  bool isDataExist = false;

  late LayoutModel layoutModel;

  Future<void> checkDataExist() async {
    var dataBase = await db;

    if (dataBase != null) {
      List<Map<String, Object?>> result = await dataBase.query(
          //"SELECT $firstColumn from $tableName where $firstColumn = 1"
          tableName,
          where: 'id = 1',
          limit: 1);
      print("result $result");
      print("result.isNotEmpty ${result.isNotEmpty}");
      isDataExist = result.isNotEmpty;
      if (result.isNotEmpty) {
        layoutModel = LayoutModel.fromJson(result[0]);
      }
    } else {
      print("dataBase != null ${dataBase != null}");
      _db = await initDatabase();
      await checkDataExist();
      // int result = await client!.rawInsert("INSERT INTO $tableName ($firstColumn, $secondColumn)"
      //         " VALUES (0, ${layoutModel.data})");
      // print("insert result $result");
    }
  }

  Future<void> updateTable(LayoutModel layoutModel) async {
    var dataBase = await db;

    if (dataBase != null) {
      String serializedData = jsonEncode(layoutModel);
      int result = await dataBase.rawUpdate(
          "UPDATE $tableName SET $secondColumn = ? WHERE $firstColumn = ?",
          [serializedData, 1]);

      print("update result $result");
    } else {
      print("dataBase != null ${dataBase != null}");
      _db = await initDatabase();
      await updateTable(layoutModel);
      // int result = await client!.rawInsert("INSERT INTO $tableName ($firstColumn, $secondColumn)"
      //         " VALUES (0, ${layoutModel.data})");
      // print("insert result $result");
    }
  }

  Future<void> readData() async {
    var dataBase = await db;

    if (dataBase != null) {
      List<Map<String, Object?>> result = await dataBase.query(
          //"SELECT $firstColumn from $tableName where $firstColumn = 1"
          tableName,
          where: 'id = 1',
          limit: 1);

      print("result $result");
      print("read result.isNotEmpty ${result.isNotEmpty}");

      if (result.isNotEmpty) {
        print(
            "result[0][layout_model].runtimeType ${result[0]["layout_model"].runtimeType}");
        String layoutModelJson = result[0]["layout_model"] as String;

        var layoutModelData = jsonDecode(layoutModelJson);

        print("layoutModelData.runtimeType ${layoutModelData.runtimeType}");

        layoutModel = LayoutModel.fromJson(layoutModelData);
        // layoutModel = LayoutModel.fromJson(result[0]["layout_model"]);
      }
    } else {
      print("dataBase != null ${dataBase != null}");
      _db = await initDatabase();
      await readData();
      // int result = await client!.rawInsert("INSERT INTO $tableName ($firstColumn, $secondColumn)"
      //         " VALUES (0, ${layoutModel.data})");
      // print("insert result $result");
    }
  }

  Future<List<CartProductModel>> getCartList() async {
    var client = await db;
    final List<Map<String, Object?>> queryResult = await client!.query('cart');
    return queryResult.map((e) => CartProductModel.fromMap(e)).toList();
  }
}
