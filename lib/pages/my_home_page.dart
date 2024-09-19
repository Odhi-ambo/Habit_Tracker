import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_drawer.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/components/my_heat_map.dart';
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

  // Text Controller
  final TextEditingController textController = TextEditingController();

  // Create habit
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
                // Save button
                MaterialButton(
                  onPressed: () {
                    // Get the new habit
                    String newHabitName = textController.text;

                    // Save to db
                    context.read<HabitDatabase>().addHabit(newHabitName);

                    // Pop box
                    Navigator.pop(context);

                    // Clear textcontroller
                    textController.clear();
                  },
                  child: const Text('Save'),
                ),
                // Cancel button
                MaterialButton(
                  onPressed: () {
                    // Pop the box
                    Navigator.pop(context);

                    // Clear controller
                    textController.clear();
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  // Check habit on and off
  void checkHabitOnOff(bool? value, Habit habit) {
    // Update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  // Edit habit box
  void editHabitBox(Habit habit) {
    // Set the controller's text to habit's current name
    textController.text = habit.name;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                // Save button
                MaterialButton(
                  onPressed: () {
                    // Get the new habit name
                    String newHabitName = textController.text;

                    // Save to db
                    context
                        .read<HabitDatabase>()
                        .updateHabitName(habit.id, newHabitName);
                    // Pop box
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
                // Cancel button
                MaterialButton(
                  onPressed: () {
                    // Pop box
                    Navigator.pop(context);

                    // Clear controller
                    textController.clear();
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  // Delete habit
  void deleteHabitBox(Habit habit) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Are you sure you want to delete?'),
              actions: [
                // Delete button
                MaterialButton(
                  onPressed: () {
                    // Save to db
                    context.read<HabitDatabase>().deleteHabitName(habit.id);
                    // Pop box
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
                // Cancel button
                MaterialButton(
                  onPressed: () {
                    // Pop box
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            ));
  }

  // Build heatmap
  Widget buildHeatMap() {
    // Habit database
    final habitDatabase = context.watch<HabitDatabase>();
    // Current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;
    // Return heatmap
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(),
      builder: (context, snapshot) {
        // Once the data is available -> build heatmap
        if (snapshot.hasData) {
          return MyHeatMap(
              startDate: snapshot.data!,
              datasets: prepHeatMapDataSet(currentHabits));
        }
        // Handle case where no data is returned
        else {
          return Container();
        }
      },
    );
  }

  // Build habit list
  Widget buildHabitList() {
    // Habit db
    final habitDatabase = context.watch<HabitDatabase>();

    // Current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    // Return lists of habits UI
    return ListView.builder(
        itemCount: currentHabits.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          // Get each individual habit
          final habit = currentHabits[index];

          // Check if the habit is completed today
          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          // Return habit tile UI
          return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value, habit),
            editHabit: (context) => editHabitBox(habit),
            deleteHabit: (context) => deleteHabitBox(habit),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
      body: ListView(
        children: [
          // HEATMAP
          buildHeatMap(),

          // HABIT LIST
          buildHabitList(),
        ],
      ),
    );
  }
}
