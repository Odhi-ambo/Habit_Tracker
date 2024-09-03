import 'package:flutter/material.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final text;
  const MyHabitTile({super.key, required this.isCompleted, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(text),
    );
  }
}
