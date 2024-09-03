import 'package:flutter/material.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  const MyHabitTile({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.secondary),
    );
  }
}
