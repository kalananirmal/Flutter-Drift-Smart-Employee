import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:smart_employee/data/local/db/entity/employee_entity.dart';
part 'app_db.g.dart';

LazyDatabase _openConnetion() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'employee.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Employee])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnetion());

  @override
  int get schemaVersion => 1;

//get list of employee
  Future <List<EmployeeData>> getEmployees () async {
    return await select(employee).get();
  }

  Stream <List<EmployeeData>> getStreamEmployees ()  {
    return  select(employee).watch();
  }

  Future<EmployeeData> getEmployee(int id) async {
    return await (select(employee)..where((tbl) => tbl.id.equals(id))).getSingle();
  }
  Future <bool> updateEmployee (EmployeeCompanion entity) async {
    return await update(employee).replace(entity);
  }
  Future<int> insertEmployee (EmployeeCompanion entity) async {
    return await into(employee).insert(entity);
  }

  Future <int>deleteEmployee (int id) async {
    return await (delete(employee)..where((tbl) => tbl.id.equals(id))).go();
  }


// Stream <EmployeeData> getStreamEmployee (int id) {
//   return (select(employee)..where((tbl) => tbl.id.equals(id))).watchSingle();
// }


}
