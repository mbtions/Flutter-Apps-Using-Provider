import 'package:fitnesstrackerapp/providers/bmi_provider.dart';
import 'package:fitnesstrackerapp/providers/summary_provider.dart';
import 'package:fitnesstrackerapp/providers/workout_provider.dart';
import 'package:fitnesstrackerapp/screens/home_screen.dart';
import 'package:fitnesstrackerapp/theme/my_app_light_theme.dart';
import 'package:fitnesstrackerapp/theme/my_app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  const FitnessTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => BMIProvider()),
      ],
      child: MaterialApp(
        title: 'Fitness Tracker App',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: myAppTheme,
      ),
    );
  }
}
