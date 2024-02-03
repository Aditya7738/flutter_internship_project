
import 'package:Tiara_by_TJ/model/cart_product_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper{

  static Database? _db;

  Future<Database?> get db async {
    if(_db != null){
      return _db!;
    }

    _db = await initDatabase();
    return null;
  }
  
  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();  //creating db in local storage
    String path = join(documentDirectory.path, 'cart.db'); //path of db
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("DATABASE CREATED");
    return db;
  }
  


  _onCreate(Database db, int version) async {
    String sql = "CREATE TABLE cart (cartProductid INTEGER PRIMARY_KEY, price VARCHAR, productName TEXT, quantity INTEGER, size INTEGER, deliveryDate VARCHAR, imageUrl TEXT);";

    await db.execute(sql);
    print("TABLE CREATED");
  }

  Future<CartProductModel> insert(CartProductModel cartProductModel) async{
    var client = await db;
    //client.delete();[]
    if(client != null){
      print("CART INSERT");
    print(cartProductModel.toMap().toString());
    await client.insert('cart', cartProductModel.toMap());
    print("CART INSERTED");
    return cartProductModel;
    }else{
      _db = await initDatabase();
      await insert(cartProductModel);
      return cartProductModel;
    }
    
    
  }

  Future<List<CartProductModel>> getCartList() async{
    var client = await db;
    final List<Map<String, Object?>> queryResult = await client!.query('cart');
    return queryResult.map((e) => CartProductModel.fromMap(e)).toList();

  }
}