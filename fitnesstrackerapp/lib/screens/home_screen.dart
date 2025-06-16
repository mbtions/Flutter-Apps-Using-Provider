import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:fitnesstrackerapp/screens/add_workout_screen.dart';
import 'package:fitnesstrackerapp/screens/bmi_screen.dart';
import 'package:fitnesstrackerapp/screens/summary_screen.dart';
import 'package:fitnesstrackerapp/widgets/workout_list.dart';
import 'package:provider/provider.dart';
import 'package:fitnesstrackerapp/providers/workout_provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  void _onAddNewWorkoutPress() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddWorkoutScreen()));
  }

  void _removeWorkout(Workout workout, int index) {
    Provider.of<WorkoutProvider>(context, listen: false).removeWorkout(workout);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Workout removed'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            Provider.of<WorkoutProvider>(
              context,
              listen: false,
            ).insertWorkoutAt(index, workout);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          final workouts = workoutProvider.workouts;
          return Scaffold(
            appBar: AppBar(title: const Text('Fitness Tracker')),
            body: workouts.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/empty_workout.png',
                              width: double.infinity,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No workouts registered yet.',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Your Workouts',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: WorkoutList(
                            workouts: workoutProvider.workouts,
                            onRemoveWorkout: _removeWorkout,
                          ),
                        ),
                      ],
                    ),
                  ),

            //
            floatingActionButton: FloatingActionButton(
              onPressed: _onAddNewWorkoutPress,
              backgroundColor: const Color(0xFFB76D68),
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
      BmiScreen(),
      SummaryScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: ((int index) {
          setState(() {
            currentPageIndex = index;
          });
        }),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.monitor_weight), label: 'BMI'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Summary'),
        ],
      ),
      body: pages[currentPageIndex],
    );
  }
}
