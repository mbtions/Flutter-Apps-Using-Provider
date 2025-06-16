import 'package:flutter/foundation.dart';
import '../model/workout.dart'; // Workout Model

class WorkoutProvider with ChangeNotifier {
  final List<Workout> _workouts = [
    Workout(
      title: "Push Ups",
      category: FitnessCategory.strength,
      duration: 10,
      date: DateTime.now(),
    ),
    Workout(
      title: "Surya Namaskar Asana",
      category: FitnessCategory.yoga,
      duration: 15,
      date: DateTime.now(),
    ),
  ];

  /// Getter to access the list externally
  List<Workout> get workouts => List.unmodifiable(_workouts);

  /// Add a workout to the list
  void addWorkout(Workout workout) {
    _workouts.add(workout);
    notifyListeners();
  }

  /// Remove a workout by reference
  void removeWorkout(Workout workout) {
    _workouts.remove(workout);
    notifyListeners();
  }

  /// Remove workout at a specific index
  void removeWorkoutAt(int index) {
    if (index >= 0 && index < _workouts.length) {
      _workouts.removeAt(index);
      notifyListeners();
    }
  }

  /// Insert workout at a specific index
  void insertWorkoutAt(int index, Workout workout) {
    _workouts.insert(index, workout);
    notifyListeners();
  }

  /// Clear all workouts
  void clearWorkouts() {
    _workouts.clear();
    notifyListeners();
  }

  /// Replace all workouts (e.g., for loading from local storage)
  void setWorkouts(List<Workout> newWorkouts) {
    _workouts
      ..clear()
      ..addAll(newWorkouts);
    notifyListeners();
  }

  /// Get workouts filtered by category (if needed)
  List<Workout> getWorkoutsByCategory(FitnessCategory category) {
    return _workouts.where((w) => w.category == category).toList();
  }

  /// Get total workout duration
  double get totalDuration {
    return _workouts.fold(0.0, (sum, item) => sum + item.duration);
  }

  /// Get workout count
  int get count => _workouts.length;

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
