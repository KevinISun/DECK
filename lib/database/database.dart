import 'package:sqflite/sqflite.dart' as sql;
//import 'package:path/path.dart';
//import 'package:sqflite/sqlite_api.dart';
import 'create_table.dart';
import 'package:deck_project/models/clothes_model.dart';

import 'dart:developer' as developer;

class SQLHelper {
  // Creates the tables
  static Future<void> createTables(sql.Database database) async {
    // create table items is the table thing
    await database.execute(createTableItems);
  }

  static Future<sql.Database> db() async {
    final db = sql.openDatabase(
      'data.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
    developer.log('Database opened $db');
    return db;
  }

//   CREATE TABLE clothes.tops (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(255) NOT NULL,
//     color VARCHAR(255) NOT NULL,
//     warmth_level INTEGER NOT NULL
//     CHECK (warmth_level >= 1 and warmth_level <= 5)
// );
  static Future<int> createItem(Clothes clothes) async {
    final db = await SQLHelper.db();
    return await db.insert('clothes', clothes.toMap(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Clothes>> getItems() async {
    final db = await SQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query('clothes');
    return List.generate(maps.length, (i) {
      return Clothes(
        id: maps[i]['id'],
        name: maps[i]['name'],
        color: maps[i]['color'],
        warmthLevel: maps[i]['warmth_level'],
        type: maps[i]['type'],
      );
    });
  }

  static Future<int> updateItem(Clothes clothes) async {
    final db = await SQLHelper.db();
    return await db.update("clothes", clothes.toMap(),
        where: 'id = ?',
        whereArgs: [clothes.id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<int> deleteItem(Clothes clothes) async {
    final db = await SQLHelper.db();
    return await db.delete('clothes', where: 'id = ?', whereArgs: [clothes.id]);
  }

  static Future<void> deleteAllItems() async {
    final db = await SQLHelper.db();
    await db.delete('clothes');
  }

  static Future<void> deleteAllTables() async {
    final db = await SQLHelper.db();
    await db.execute('DROP TABLE IF EXISTS clothes');
  }

  static Future<List<Clothes>> generateOutfits() async {
    final db = await SQLHelper.db();

    // Create a list to store retrieved clothes
    final List<Map<String, dynamic>> outfits = [];

    // Get distinct types to ensure variety
    final List<String> types = ['Tops', 'Bottoms', 'Outerwear', 'Shoes'];

    for (String type in types) {
      Map<String, dynamic> item = await db
          .rawQuery(
              "SELECT * FROM clothes WHERE type = ? ORDER BY RANDOM() LIMIT 1",
              [type])
          .then((maps) => maps.first);
      outfits.add(item);
    }

    return List.generate(outfits.length, (i) {
      return Clothes(
        id: outfits[i]['id'],
        name: outfits[i]['name'],
        color: outfits[i]['color'],
        warmthLevel: outfits[i]['warmth_level'],
        type: outfits[i]['type'],
      );
    });
  }
}
