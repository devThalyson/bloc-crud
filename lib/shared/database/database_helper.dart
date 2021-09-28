import 'dart:io';

import 'package:bloc_crud/shared/models/post_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String postTable = "post";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colCreationDate = 'creationDate';
  String colPhotoUrl = "photoUrl";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "posts.db";
    var todosDatabase =
        await openDatabase(path, onCreate: _createDb, version: 1);
    return todosDatabase;
  }

  _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $postTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDescription TEXT, $colPhotoUrl TEXT, $colCreationDate TEXT)');
  }

  //insert post
  Future<int> insertPost(PostModel post) async {
    Database db = await this.database;

    var response = await db.insert(postTable, post.toMap());

    return response;
  }

  //get posts
  Future<List<PostModel>> getPosts() async {
    Database db = await this.database;

    var response = await db.query(postTable);

    List<PostModel> posts = response.isNotEmpty
        ? response.map((e) => PostModel.fromMap(e)).toList()
        : [];
    return posts;
  }

  //update post
  Future<int> updatePost(PostModel post) async {
    var db = await this.database;

    var response = await db.update(
      postTable,
      post.toMap(),
      where: '$colId = ?',
      whereArgs: [post.id],
    );

    return response;
  }

  //delete post
  Future<int> deletePost(int id) async {
    var db = await this.database;
    int response =
        await db.delete(postTable, where: "$colId = ?", whereArgs: [id]);
    return response;
  }

  //close db
  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
