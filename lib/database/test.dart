import 'package:test/test.dart';
import 'database.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  print("Running tests");
  test('createItem', () async {
    final id = await SQLHelper.createItem('prada', 'black', 2);
    expect(id, 1);
  });

  test('getItems', () async {
    await SQLHelper.printAllItems();
    
  });
  test('getItemWithId', () async {
    final data = await SQLHelper.getItemWithId(13);
    expect(data, {'name': 'prada', 'color': 'black', 'warmth_level': 2});
    
  });
 

}