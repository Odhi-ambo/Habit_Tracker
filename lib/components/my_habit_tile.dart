import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  const MyHabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      required this.onChanged,
      required this.editHabit});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        //edit option
        SlidableAction(
          onPressed: editHabit,
          backgroundColor: Colors.grey,
          icon: Icons.settings,
          borderRadius: BorderRadius.circular(8),
        ),
        //delete option
      ]),
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) {
            //togggle completion status
            onChanged!(!isCompleted);
          }
        },
        child: Container(
            decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: ListTile(
              title: Text(text),
              leading: Checkbox(
                activeColor: Colors.green,
                value: isCompleted,
                onChanged: onChanged,
              ),
            )),
      ),
    );
  }
}
