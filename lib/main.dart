import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Habit Tracker',
      home: MyHomePage(),
    );
  }
}
