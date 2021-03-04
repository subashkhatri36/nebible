import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'nebible.db';
  static final _dbVersion = 1;

  //table names
  static final tableSetting = 'Setting';
  static final tableReminder = 'Reminder';
  static final tableBookmark = 'Bookmark';
  static final tableMark = 'Mark';
  static final tableBook = 'Book';
  static final tableTodayVerse = 'TodayVerse';
  static final tablePrayer = 'Prayer';

  //column Name of setting table
  static final id = 'id';
  static final font = 'font';
  static final screenawak = 'screenawak';

  static final today = 'today';

  //Table  Reminder of prayer
  static final ptime = '_time';
  static final ptype = 'type'; //daily weekly morning prayer evening prayer
  static final reminder = 'reminder';
  static final title = 'title';
  static final description = 'description';

  //Table Bookmarks
  static final bname = 'bookname';
  static final bchapter = 'chapter';
  static final bverse = 'verse';

  //Table for versemark
  static final mcolor = 'color';

  //Table for book
  static final blanguge = 'language';

  //Table for prayer
  static final pcategory = 'Category';

  //Table

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) {
    db.execute(''' 
      CREATE TABLE $tableSetting( $id INTEGER PRIMARY KEY,      
       $font INTEGER NOT NULL,
       $screenawak INTEGER NOT NULL,
       $blanguge TEXT NOT NULL
       )
      ''');

    db.execute(''' 
      CREATE TABLE $tableBookmark( $id INTEGER PRIMARY KEY,
       $bname TEXT NOT NULL,
       $bchapter INTEGER NOT NULL,
       $bverse INTEGER NOT NULL,       
       $description TEXT NOT NULL
       )
      ''');
    db.execute(''' 
      CREATE TABLE $tableMark( $id INTEGER PRIMARY KEY,
       $bname TEXT NOT NULL,
       $bchapter INTEGER NOT NULL,
       $bverse INTEGER NOT NULL,       
       $mcolor TEXT NOT NULL
       )
      ''');
    db.execute(''' 
      CREATE TABLE $tableBook( $id INTEGER PRIMARY KEY,
       $bname TEXT NOT NULL,
       $bchapter INTEGER NOT NULL,
       $bverse INTEGER NOT NULL  
       )
      ''');
    db.execute(''' 
      CREATE TABLE $tableTodayVerse( $id INTEGER PRIMARY KEY,      
       $bverse INTEGER NOT NULL ,    
          $today TEXT NOT NULL
       )
      ''');
    db.execute(''' 
      CREATE TABLE $tablePrayer( $id INTEGER PRIMARY KEY,
       $title TEXT NOT NULL,
       $description TEXT NOT NULL,
       $ptype TEXT NOT NULL,       
       $pcategory TEXT NOT NULL
       )
      ''');
    return null;
  }

  Future<int> insert(Map<String, dynamic> row, String tablename) async {
    Database db = await instance.database;
    return await db.insert(tablename, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tablename) async {
    Database db = await instance.database;
    return await db.query(tablename);
  }

  Future<List<Map<String, dynamic>>> singledata(
      String tablename, int idd) async {
    Database db = await instance.database;
    return await db.query(tablename, where: '$id=?', whereArgs: [idd]);
  }

  Future<int> update(
      Map<String, dynamic> row, String tablename, int _id) async {
    Database db = await instance.database;
    return await db.update(tablename, row, where: '$id= ?', whereArgs: [_id]);
  }

  Future<int> detele(int id, String tablename) async {
    Database db = await instance.database;
    return await db.delete(tablename, where: '$id=?', whereArgs: [id]);
  }
}
