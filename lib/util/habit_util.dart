/*given ahabit list of completed days
is the habit completed today*/

import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}

//prepare heatmap dataset
Map<DateTime, int> prepHeatMapDataSet(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      //normalize date to avoid time mismatch
      final normalizeDate = DateTime(date.year, date.month, date.day);
    }
  }
}
