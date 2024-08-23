import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

/*
setup

*/

//INITIALIZE DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

//save first date of app when starting for the first time
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //get first date of app during startup(for heatmap)
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  c r u d ops
  */
  //list of habit
  final List<Habit> currentHabits = [];

  //CREATE- add a new habit
  Future<void> addHabit(String habitName) async {
    //create a new habit
    final newHabit = Habit()..name = habitName;

    //save to DB
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //re-read from DB
    readHabits();
  }

//READ- read saved habits from DB
  Future<void> readHabits() async {
    //fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update UI
    notifyListeners();

    //UPDATE - check habit on and off

    Future<void> updateHabitCompletion(int id, bool isCompleted) async {
      //find the specific habit
      final habit = await isar.habits.get(id);

      //update completion status
      if (habit != null) {
        await isar.writeTxn(() async {
          //if habit is completed -> add the current date to the completed days list
          if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
          }
          //if habit is not completed  -> remove the current date from the list
          else {}
        });
      }
      //re -read from db
    }
    //UPDATE- update habit

    //DELETE-delete habit
  }
}
