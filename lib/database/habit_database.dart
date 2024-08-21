import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {}

/*
setup

*/

//INITIALIZE DB
Future<void> initialize() async {
  final dir = await getApplicationDocumentsDirectory();
}
