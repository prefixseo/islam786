import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseInit{
  static const tasbihTable = 'tasbih';
  static const id = 'id';
  static const name = 'name';
  static const set = '_set';
  static const count = '_count';

  static void dbLog(String _f, String _sql,[List<Map<String, dynamic>> queryRes, int insnuptres]){
//    print(_f);
//    print(_sql);
    if(queryRes != null){
      print(queryRes);
    }else if(insnuptres != null){
      print(insnuptres);
    }
  }


  Future<void> initTable(Database db) async {
    final _tasbihTableSql = '''create table $tasbihTable
    (
      $id INTEGER PRIMARY KEY AUTOINCREMENT,
      $name TEXT,
      $set INTEGER,
      $count INTEGER
    )''';

    await db.execute(_tasbihTableSql);
  }


  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath,dbName);

    if(await Directory(dirname(path)).exists()){
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }


  Future<void> initDatabase() async {
    final path = await getDatabasePath("tasbih");
    db = await openDatabase(path, version: 1, onCreate: oncreate);
    print(db);
  }


  Future<void> oncreate(db,ver) async {
    await initTable(db);
  }

}