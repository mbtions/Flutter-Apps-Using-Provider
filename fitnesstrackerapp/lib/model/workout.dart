// for the internationalization that supports formatting of data
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// enum variable Cateogry to store different categories
enum FitnessCategory { strength, cardio, flexibility, balance, yoga, other }

// to use uuid functions which helps in creating unique IDs without collision
final uuid = Uuid();

// to format the datetime
final formatter = DateFormat().add_yMd();

// a workout model with specific attributes and functionalities
class Workout {
  Workout({
    required this.title,
    required this.category,
    required this.duration,
    required this.date,
  }) : id = uuid.v4();

  final String id; // workout id
  final String title; // workout title (eg. Push Ups)
  final FitnessCategory category; // workout category (eg. strength)
  final double duration; // workout duration (eg. 20 mins)
  final DateTime date; // workout date (eg. 06/08/2025 i.e. Jun 06, 2025)

  // function to get formatted date based on the format string passed during call
  String formattedDate({formatString = "yMd"}) {
    return switch (formatString) {
      "y" => DateFormat().add_y().format(date),
      "yM" => DateFormat().add_yMMM().format(date),
      "MMM" => DateFormat().add_MMM().format(date),
      "MMMd" => DateFormat().add_MMMd().format(date),
      _ => formatter.format(date),
    };
  }

  Widget getCategoryIcon() {
    return switch (category) {
      FitnessCategory.strength => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(Icons.fitness_center, size: 30),
      ),
      FitnessCategory.cardio => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(Icons.directions_run, size: 30),
      ),
      FitnessCategory.flexibility => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(185),
        child: Icon(Icons.accessibility_new, size: 30),
      ),
      FitnessCategory.balance => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(Icons.balance, size: 30),
      ),
      FitnessCategory.yoga => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(Icons.self_improvement, size: 30),
      ),
      _ => CircleAvatar(
        backgroundColor: getCategoryColor().withAlpha(175),
        child: Icon(Icons.category, size: 30),
      ),
    };
  }

  Color getCategoryColor() {
    return switch (category) {
      FitnessCategory.strength => Colors.red.shade600,
      FitnessCategory.cardio => Colors.blue.shade600,
      FitnessCategory.flexibility => Colors.green.shade600,
      FitnessCategory.balance => Colors.yellow.shade600,
      FitnessCategory.yoga => Colors.purple.shade600,
      _ => Colors.grey.shade600,
    };
  }
}
