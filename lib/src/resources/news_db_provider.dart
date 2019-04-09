import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item_model.dart';
import 'repository.dart';

/*
Source: "getting from api", "getting from db"
Cache: "saving to db"
 */
class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
          newDb.execute('''
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              url TEXT,
              score INTEGER,
              title TEXT,
              descendants INTEGER
            )
          ''');
        });
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: 'id=?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(
      'Items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  //TODO : this is a dummy method for now to satisfy the abstract class constrains
  Future<List<int>> fetchTopIds() {
    return null;
  }

  Future<int> clear() {
    return db.delete('items');
  }

}

//calls the constructor and makes the db connection singleton
final newsDbProvider = NewsDbProvider();
