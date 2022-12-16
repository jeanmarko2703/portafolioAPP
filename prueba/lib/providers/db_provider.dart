

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prueba/models/models.dart';
import 'package:sqflite/sqflite.dart';

  // String id;
  //   String title;
  //   String subtitle;
  //   String imageUrl;
  //   int v;
  //   String description;
  //   bool isMobile;
  //   String url;

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
  
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'projectsDB.db');
    print(path);
   

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          ''' CREATE TABLE Projects(id INTEGER PRIMARY KEY,_id TEXT, title TEXT, subtitle TEXT, imageUrl TEXT, __v INTEGER, description TEXT, url STRING ) ''');
      
    });

  
  }

  Future<int> newProject(Project newProject) async {
    final db = await database;
    final res = await db.insert('Projects',newProject.toMap() );

    return res;
  }

  Future<List<Project>> projects() async {
    final db = await database;
    final res = await db.query('Projects');

    return res.isNotEmpty ? res.map((e) => Project.fromMap(e)).toList() : [];
  }

  Future<int> deleteProject(String id) async {
    final db = await database;

    final res = await db.delete('Projects', where: 'id = ?', whereArgs: [id]);
    return res;
  }

 

}
