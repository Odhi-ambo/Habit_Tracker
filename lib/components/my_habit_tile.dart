import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const MyHabitTile(
      {super.key,
      required this.isCompleted,
      required this.text,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          //edit option
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.grey,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          //delete option
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          )
        ]),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              //togggle completion status
              onChanged!(!isCompleted);
            }
          },
          //habit tile
          child: Container(
              decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green
                      : Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(12),
              child: ListTile(
                title: Text(text),
                //checkbox
                leading: Checkbox(
                  activeColor: Colors.green,
                  value: isCompleted,
                  onChanged: onChanged,
                ),
              )),
        ),
      ),
    );
  }
}
