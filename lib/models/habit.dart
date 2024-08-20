import 'package:isar/isar.dart';

@collection
class Habit {
  //habit id
  Id id = Isar.autoIncrement;

  //habit name
  late String name;

  //completed days
  List<DateTime> completedDays = [
    // DateTime(year, month, day),
    // DateTime(2024, 8, 19),
    // DateTime(2024,8, 19),
  ];
}
