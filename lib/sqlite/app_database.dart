import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/medicao_dao.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'Dados.db');

  return await openDatabase(path, onCreate: (db, version) {
    db.execute(MedDao().createTableQuery);
  }, version: 1);
}
