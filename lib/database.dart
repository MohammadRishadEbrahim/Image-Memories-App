import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path_provider/path_provider.dart';

class DataHelper {
  static Future<Database> database() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '$directory/mydata.db';
    return sql.openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE user_image(id TEXT PRIMARY KEY ,title TEXT,image TEXT,story TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE user_image(id TEXT PRIMARY KEY,title TEXT,image TEXT,story TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete('user_image');
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DataHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DataHelper.database();
    return db.query(table);
  }

  static Future<void> deleteData(String table) async {
    final db = await DataHelper.database();
    db.delete(table);
  }
}
