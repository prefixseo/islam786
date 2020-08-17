import 'package:Islam786/_model/Tasbih.dart';
import 'package:Islam786/_utils/_tasbihDatabase.dart';

class ActionServiceTasbih{
  static Future<List<TasbihData>> getAllTasbih() async {
    final sql = '''SELECT * FROM ${DatabaseInit.tasbihTable}''';
    final data = await db.rawQuery(sql);
    List<TasbihData> _tasbihs = List();
    for (final node in data){
      final _TasbihArchive = TasbihData.fromJson(node);
      _tasbihs.add(_TasbihArchive);
    }
    return _tasbihs;
  }


  static Future<TasbihData> getTasbih(id) async {
    final sql = '''SELECT * FROM ${DatabaseInit.tasbihTable}
    WHERE ${DatabaseInit.id} == $id''';

    final data = await db.rawQuery(sql);
    final tasbih = TasbihData.fromJson(data[0]);
    return tasbih;
  }


  static Future<void> AddTasbih(name,count) async {
    final sql = '''INSERT INTO ${DatabaseInit.tasbihTable}
    (
      ${DatabaseInit.name},
      ${DatabaseInit.count},
      ${DatabaseInit.set}
    )
    VALUES
    (
      "${name}",
      ${count},
      0
    )''';

    final result = await db.rawInsert(sql);
    DatabaseInit.dbLog("addTasbih", sql,null,result);
  }


  static Future<void> updateSet(int set,int id) async {
    final sql = '''UPDATE ${DatabaseInit.tasbihTable}
    SET ${DatabaseInit.set} = ${set}
    WHERE ${DatabaseInit.id} == ${id}''';

    final result = await db.rawUpdate(sql);
    DatabaseInit.dbLog("UpdateSet", sql, null,result);
  }


  static Future<void> updateTasbih(id,name,count) async {
    final sql = '''UPDATE ${DatabaseInit.tasbihTable}
    SET ${DatabaseInit.name} = "${name}", ${DatabaseInit.count} = ${count}
    WHERE ${DatabaseInit.id} == ${id}''';

    final result = await db.rawQuery(sql);
    DatabaseInit.dbLog("UpdateTasbih", sql, result);
  }


  static Future<void> deleteTasbih(id) async {
    final sql = '''DELETE FROM ${DatabaseInit.tasbihTable}
    WHERE ${DatabaseInit.id} == ${id}''';

    final result = await db.rawQuery(sql);
    DatabaseInit.dbLog("deleteTasbih", sql,result);
  }

}