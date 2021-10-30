import 'package:ponddata/model/med.dart';
import 'package:sqflite/sqlite_api.dart';
import '../app_database.dart';
import 'dao.dart';

class MedDao implements Dao<Med> {
  @override
  final tableName = 'medicoes';

  @override
  final String id = 'id';
  final String _nome = 'nome';
  final String _o2 = 'o2';
  final String _sat = 'sat';
  final String _temp = 'temp';
  final String _ph = 'ph';

  static MedDao instance() {
    return MedDao();
  }

  @override
  String get createTableQuery => "CREATE TABLE $tableName("
      " $id INTEGER PRIMARY KEY,"
      " $_nome TEXT,"
      " $_o2 TEXT,"
      " $_sat TEXT,"
      " $_temp TEXT,"
      " $_ph TEXT)";

  @override
  String get deleteAllRowsQuery => "DELETE FROM $tableName";

  @override
  Future<Med> fromMap(Map<String, dynamic> query) async {
    return Med.fromJson(query);
  }

  @override
  Map<String, dynamic> toMap(Med object) {
    return object.toJson();
  }

  @override
  Future<List<Med>> fromList(List<Map<String, dynamic>> query) async {
    List<Med> objList = [];
    for (Map<String, dynamic> map in query) {
      objList.add(await fromMap(map));
    }
    return objList;
  }

  @override
  Future<Med?> getObj(String objId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: '$id = ?', whereArgs: [objId]);
    if (maps.isNotEmpty) {
      return fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> getObjMap(String objId) async {
    final Database db = await getDatabase();
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: '$id = ?', whereArgs: [objId]);
    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }
}
