import 'package:isar/isar.dart';

class Habit {
  //habit id
  Id id = Isar.autoIncrement;

  //habit name
  late String name;

  //completed days
  List<DateTime> completedDays = [];
}
