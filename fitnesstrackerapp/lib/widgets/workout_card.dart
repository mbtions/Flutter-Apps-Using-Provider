import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            workout.getCategoryIcon(),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Text(
                    workout.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    // const TextStyle(
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  SizedBox(height: 3),
                  Card(
                    color: Colors.white12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(3),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        workout.category.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall,
                        // TextStyle(
                        //   color: workout.getCategoryColor(),
                        //   fontWeight: FontWeight.bold,
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  // '${workout.date.month} ${workout.date.day}, ${workout.date.year}',
                  workout.formattedDate(formatString: "MMMd"),
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  "${workout.duration.toInt()} min",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
