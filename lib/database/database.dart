import 'package:sqflite/sqflite.dart' as sql;
//import 'package:path/path.dart';
//import 'package:sqflite/sqlite_api.dart';
import 'create_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:developer' as developer;

class SQLHelper {
  // Creates the tables
  static Future<void> createTables(sql.Database database) async {
    // create table items is the table thing
    await database.execute(createTableItems);
  }

  static Future<sql.Database> db() async {
    developer.log('Trying to open database');
    final db = sql.openDatabase(
      'clothes.db',
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
  static Future<int> createItem(String name, String color, int warmth_level) async {
    developer.log('Creating item: $name, $color, $warmth_level');
    final db = await SQLHelper.db();
    final data = {'name': name, 'color': color, 'warmth_level': warmth_level};

    final id = await db.insert('clothes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('clothes', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItemWithId(int id) async {
    final db = await SQLHelper.db();

    return db.query('clothes', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
      int id, String name, String color, int warmth_level) async {
    final db = await SQLHelper.db();
    final data = {'name': name, 'color': color, 'warmth_level': warmth_level};
    final result =
        await db.update('clothes', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('clothes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting item: $e");
    }
  }

  static Future<void> printAllItems() async {
    final db = await SQLHelper.db();
    final items = await db.query('clothes');
    items.forEach((item) {
      print(item);
    });
  }

  static Future<void> deleteAllItems() async {
    final db = await SQLHelper.db();
    await db.delete('clothes');
  }
}
