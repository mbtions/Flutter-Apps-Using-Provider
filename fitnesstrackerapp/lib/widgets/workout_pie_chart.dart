import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:provider/provider.dart';
import 'package:fitnesstrackerapp/providers/workout_provider.dart';

class WorkoutPieChart extends StatefulWidget {
  const WorkoutPieChart({super.key});

  @override
  State<WorkoutPieChart> createState() => _WorkoutPieChartState();
}

class _WorkoutPieChartState extends State<WorkoutPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutProvider>(
      builder: (context, workoutProvider, child) {
        // total workouts
        final total = workoutProvider.count;
        // no workout => no data
        if (total == 0) {
          return const Center(
            child: Text(
              "No data to show",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return AspectRatio(
          aspectRatio: 1.2,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PieChart(
                        PieChartData(
                          startDegreeOffset: 180,
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!
                                        .touchedSectionIndex;
                                  });
                                },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 4,
                          centerSpaceRadius: double.infinity,
                          sections: _generateSections(
                            workoutProvider.categoryCounts,
                            workoutProvider.count,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      width: 150,
                      top: 120,
                      child: Column(
                        children: [
                          Text(
                            'Total Workouts:',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '$total',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _generateSections(
    Map<FitnessCategory, int> categoryCounts,
    int total,
  ) {
    final shadows = [const Shadow(color: Colors.black, blurRadius: 2)];

    return categoryCounts.entries.mapIndexed((index, entry) {
      final category = entry.key;
      final count = entry.value;
      final isTouched = index == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percent = (count / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: _getCategoryColor(category),
        value: count.toDouble(),
        title: '$percent%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      );
    }).toList();
  }

  Color _getCategoryColor(FitnessCategory category) {
    return switch (category) {
      FitnessCategory.strength => Colors.red.shade600,
      FitnessCategory.cardio => Colors.blue.shade600,
      FitnessCategory.flexibility => Colors.green.shade600,
      FitnessCategory.balance => Colors.yellow.shade600,
      FitnessCategory.yoga => Colors.purple.shade600,
      FitnessCategory.other => Colors.grey.shade600,
    };
  }
}

// Extension for mapIndexed functionality
extension<T> on Iterable<T> {
  Iterable<E> mapIndexed<E>(E Function(int index, T item) f) {
    int index = 0;
    return map((item) => f(index++, item));
  }
}
