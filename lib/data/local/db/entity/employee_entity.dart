import 'package:drift/drift.dart';

class Employee extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().named('first_name')();
  TextColumn get lastName => text().named('last_name')();
  DateTimeColumn get dateOfBirth => dateTime().named('date_of_birth')();
  TextColumn get email => text().named('email')();
  TextColumn get phone => text().named('phone')();
}
