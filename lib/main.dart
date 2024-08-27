import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/pages/my_home_page.dart';
import 'package:habit_tracker/pages/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize db
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();
  runApp(MultiProvider(providers: [
    //habit provider]
    ChangeNotifierProvider(create: (context) => HabitDatabase()),
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      home: const MyHomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
