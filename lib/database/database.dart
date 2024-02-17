import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'create_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';




class Database {

  // Creates the tables
  static Future<void> createTables(sql.Database database) async {
    // create table items is the table thing
    await database.execute(createTableItems);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'clothes.db',
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      },
    );
  }
//   CREATE TABLE clothes.tops (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     name VARCHAR(255) NOT NULL,
//     color VARCHAR(255) NOT NULL,
//     warmth_level INTEGER NOT NULL
//     CHECK (warmth_level >= 1 and warmth_level <= 5)
// );
  static Future<int> createItem(String name, String color, String warmth_level) async {
    final db = await sql.openDatabase('clothes.db');
    final data = {'title': name, 'color': color, 'warmth_level': warmth_level};

    final id = await db.insert(
      'clothes.tops',
      data, 
      conflictAlgorithm: sql.ConflictAlgorithm.replace
    );
    return id;

  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    
    final db = await sql.openDatabase('clothes.db');
    return db.query('clothes.tops', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItemWithId(int id) async {
    final db = await sql.openDatabase('clothes.db');
    return db.query('clothes.tops', where: 'id = ?', whereArgs: [id], limit: 1);

  }

  static Future<int> updateItem(int id ,String name, String color, String warmth_level) async {
    final db = await sql.openDatabase('clothes.db');
    final data = {'title': name, 
                  'color': color, 
                  'warmth_level': warmth_level
    };
    final result = await db.update('clothes.top', data, 
                                   where: 'id = ?',
                                   whereArgs: [id]);
    return result;

  }

  static Future<void> deleteItem(int id) async {
    final db = await sql.openDatabase('clothes.db');
    try {
      await db.delete('clothes.tops', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      debugPrint("Something went wrong when deleting item: $e");
    }
  }

  
}
