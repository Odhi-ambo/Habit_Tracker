import 'package:isar/isar.dart';

@collection
class AppSettings {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}
