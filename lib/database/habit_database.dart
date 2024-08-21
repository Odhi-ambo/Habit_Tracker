import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {}

/*
setup

*/

//INITIALIZE DB
Future<void> initialize() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [HabitSchema, AppSettingsSchema],
    directory: dir.path,
  );
}

//save first date of app when starting for the first time
Future<void> saveFirstLaunchDate() async {}
