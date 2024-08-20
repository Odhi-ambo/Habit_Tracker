import 'package:isar/isar.dart';

//run cmd to generate file:dart run build_runner build
part 'habit.g.dart';

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
