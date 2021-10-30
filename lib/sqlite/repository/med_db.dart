import 'package:ponddata/model/med.dart';
import 'package:ponddata/sqlite/dao/medicao_dao.dart';
import 'generic_dao.dart';

class MedDb extends GenericDao<Med> {
  MedDb() : super(MedDao());
}
