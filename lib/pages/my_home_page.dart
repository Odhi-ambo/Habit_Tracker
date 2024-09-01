import 'package:flutter/material.dart';
import 'package:habit_tracker/database/habit_database.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //read existing habitson app startup
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
    );
  }
}
