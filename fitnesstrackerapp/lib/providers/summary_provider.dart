import 'package:flutter/material.dart';
import 'package:fitnesstrackerapp/model/workout.dart';

class SummaryProvider with ChangeNotifier {
  final List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  // Add a workout
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  // Remove a workout
  void removeWorkout(Workout workout) {
    _workouts.remove(workout);
    notifyListeners();
  }

  // Clear all workouts
  void clearWorkouts() {
    _workouts.clear();
    notifyListeners();
  }

  // Total duration of all workouts
  double get totalDuration {
    return _workouts.fold(0, (sum, item) => sum + item.duration);
  }

  // Total count of all workouts
  int get totalCount => _workouts.length;

  // Get total workouts by category
  Map<FitnessCategory, int> get categoryCounts {
    final Map<FitnessCategory, int> counts = {};
    for (var workout in _workouts) {
      counts[workout.category] = (counts[workout.category] ?? 0) + 1;
    }
    return counts;
  }

  // Get total duration by category
  Map<FitnessCategory, double> get categoryDurations {
    final Map<FitnessCategory, double> durations = {};
    for (var workout in _workouts) {
      durations[workout.category] =
          (durations[workout.category] ?? 0) + workout.duration;
    }
    return durations;
  }

  // Return workouts filtered by a specific date (optional utility)
  List<Workout> getWorkoutsByDate(DateTime date) {
    return _workouts
        .where(
          (w) =>
              w.date.year == date.year &&
              w.date.month == date.month &&
              w.date.day == date.day,
        )
        .toList();
  }
}
