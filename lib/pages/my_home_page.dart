import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/util/habit_util.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //read existing habits on app startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }

  //Text Controller
  final TextEditingController textController = TextEditingController();
  //create habit
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
                decoration:
                    const InputDecoration(hintText: 'Create a new habit'),
              ),
              actions: [
                //save button
                MaterialButton(
                  onPressed: () {
                    //get the new habit
                    String newHabitName = textController.text;

                    //save to db
                    context.read<HabitDatabase>().addHabit(newHabitName);

                    //pop box
                    Navigator.pop(context);

                    //clear textcontroller
                    textController.clear();
                  },
                  child: const Text('Save'),
                ),
                //cancel button
                MaterialButton(
                  onPressed: () {
                    //pop the box
                    Navigator.pop(context);

                    //clear controller
                    textController.clear();
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

//check habit on and off
  void checkHabitOnOff(bool? value, Habit habit) {
    //update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  //edit habit box
  void editHabitBox(Habit habit) {
    //set the controller's text to habit's current name
    textController.text = habit.name;
  }

  //delete habit

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: _buildHabitList(),
    );
  }

//build habit list
  Widget _buildHabitList() {
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return lists of habits UI
    return ListView.builder(
        itemCount: currentHabits.length,
        itemBuilder: (context, index) {
          //get each individual habit
          final habit = currentHabits[index];

          //check if the habit is completed today
          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          //return habit tile UI
          return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value, habit),
          );
        });
  }
}
