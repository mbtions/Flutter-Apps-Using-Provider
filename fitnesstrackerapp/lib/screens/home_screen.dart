import 'package:fitnesstrackerapp/model/workout.dart';
import 'package:fitnesstrackerapp/screens/add_workout_screen.dart';
import 'package:fitnesstrackerapp/screens/bmi_screen.dart';
import 'package:fitnesstrackerapp/screens/summary_screen.dart';
import 'package:fitnesstrackerapp/theme/app_colors.dart';
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
  FitnessCategory? selectedCategory;

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

  // Function to build the dropdown label
  Widget buildDropdownLabel(String filteredCategory) {
    return Text(
      // capitalize the first letter of the category name
      filteredCategory[0].toUpperCase() + filteredCategory.substring(1),
      style: Theme.of(context).textTheme.labelLarge,
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
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/images/empty_workout.png',
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No workouts registered yet.',
                            style: Theme.of(context).textTheme.headlineSmall,
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
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Your Workouts',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Spacer(),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final double parentWidth = constraints.maxWidth;
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    dropdownMenuTheme: DropdownMenuThemeData(
                                      textStyle: Theme.of(
                                        context,
                                      ).textTheme.labelLarge,
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                            suffixIconColor:
                                                AppColors.kDarkTextColor,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.kDarkTextColor,
                                                width: 1,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(30),
                                              ),
                                              borderSide: BorderSide(
                                                color: AppColors.kPrimary,
                                                width: 2,
                                              ),
                                            ),
                                            labelStyle: TextStyle(
                                              color: AppColors.kDarkTextColor,
                                            ),
                                          ),
                                      menuStyle: MenuStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                              const Color(0xFF2C2B3C),
                                            ),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        maximumSize: WidgetStateProperty.all(
                                          Size(
                                            parentWidth,
                                            double.infinity,
                                          ), // Match parent width
                                        ),
                                        elevation: WidgetStateProperty.all(5),
                                      ),
                                    ),
                                  ),
                                  child: DropdownMenu<FitnessCategory?>(
                                    initialSelection: null,
                                    trailingIcon: Icon(Icons.filter_list),
                                    dropdownMenuEntries: [
                                      DropdownMenuEntry(
                                        value: null,
                                        label: 'All',
                                        labelWidget: buildDropdownLabel("All"),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.strength,
                                        label: 'Strength',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.strength.name,
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.cardio,
                                        label: 'Cardio',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.cardio.name,
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.flexibility,
                                        label: 'Flexibility',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.flexibility.name,
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.balance,
                                        label: 'Balance',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.balance.name,
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.yoga,
                                        label: 'Yoga',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.yoga.name,
                                        ),
                                      ),
                                      DropdownMenuEntry(
                                        value: FitnessCategory.other,
                                        label: 'Other',
                                        labelWidget: buildDropdownLabel(
                                          FitnessCategory.other.name,
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: WorkoutList(
                            workouts: selectedCategory == null
                                ? workoutProvider.workouts
                                : workoutProvider.workouts
                                      .where(
                                        (w) => w.category == selectedCategory,
                                      )
                                      .toList(),
                            onRemoveWorkout: _removeWorkout,
                          ),
                        ),
                      ],
                    ),
                  ),
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
