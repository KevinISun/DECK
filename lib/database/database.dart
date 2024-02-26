import 'package:sqflite/sqflite.dart' as sql;
//import 'package:path/path.dart';
//import 'package:sqflite/sqlite_api.dart';
import 'create_table.dart';
import 'package:deck_project/models/clothes_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:developer' as developer;

class SQLHelper {
  static Future<http.Response> getWeatherData() async {
      const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
      const CITY = "Santa Cruz";
      const COUNTRY = "US";
      const apiKey = 'bbb3c38ddd6eb052bdddee16a6ca50b1';
      const apiUrl = '$BASE_URL?appid=$apiKey&q=$CITY,$COUNTRY&units=imperial';

      return await http.get(Uri.parse(apiUrl));
  }
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

  // generates an outfit by selecting
  static Future<List<Clothes>> generateOutfits() async {
    final db = await SQLHelper.db();
    final response = await SQLHelper.getWeatherData();
    final data = jsonDecode(response.body);
    
    final temperature = data['main']['temp'];
    // String description = data['weather'][0]['description'];

    // temperature under 50 degrees makes warmth level 1, 50-70 warm level 2, 70 above is warm level 3
    int warmthLevel = 1;
    if (temperature >= 50 && temperature < 70) {
      warmthLevel = 2;
    } else if (temperature >= 70) {
      warmthLevel = 3;
    }

    // Create a list to store retrieved clothes
    final List<Map<String, dynamic>> outfits = [];

    // Get distinct types to ensure variety
    final List<String> types = ['Tops', 'Bottoms', 'Outerwear', 'Shoes'];

    for (String type in types) {
      Map<String, dynamic> item = await db
          .rawQuery(
              "SELECT * FROM clothes WHERE type = ? and warmth_level = ? ORDER BY RANDOM() LIMIT 1",
              [type, warmthLevel])
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
