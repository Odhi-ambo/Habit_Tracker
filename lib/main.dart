import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/my_home_page.dart';
import 'package:habit_tracker/pages/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
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
