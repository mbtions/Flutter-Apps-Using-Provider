import 'package:fitnesstrackerapp/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fitnesstrackerapp/providers/bmi_provider.dart';
import 'package:provider/provider.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return BmiScreenState();
  }
}

class BmiScreenState extends State<BmiScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void _showDialogBox(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Input Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Underweight':
        return Colors.red;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.yellow;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121420),
      appBar: AppBar(
        title: Text('BMI'),
        centerTitle: true,
        backgroundColor: Color(0xFFB76D68),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Calculate Your BMI',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  // Image.asset is used to display an image from the assets folder
                  Image.asset(
                    'assets/images/bmi_2.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 25),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(labelText: 'Height (cm)'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(labelText: 'Weight (Kg)'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (heightController.text.isEmpty ||
                          weightController.text.isEmpty) {
                        _showDialogBox('Please enter both height and weight');
                        return;
                      } else if (double.parse(
                            heightController.text,
                          ).isNegative ||
                          double.parse(heightController.text).isNaN ||
                          heightController.text.contains(
                            "-",
                          ) || // cannot contain unexpected characters or operators
                          heightController.text.contains("/") ||
                          heightController.text.contains(" ") ||
                          double.parse(weightController.text).isNegative ||
                          weightController.text.contains(
                            "-",
                          ) || // cannot contain unexpected characters or operators or spaces
                          weightController.text.contains("/") ||
                          weightController.text.contains(" ") ||
                          double.parse(weightController.text).isNaN) {
                        _showDialogBox(
                          'Invalid input format: No negatives, spaces, or invalid operators(-, /) allowed',
                        );

                        return;
                      }

                      final double height =
                          double.parse(heightController.text) / 100;
                      final double weight = double.parse(weightController.text);

                      Provider.of<BMIProvider>(
                        context,
                        listen: false,
                      ).calculateBMI(height: height, weight: weight);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      backgroundColor: AppColors.kPrimary,
                    ),
                    child: Text(
                      'Calculate',
                      style: Theme.of(context).textTheme.bodyLarge,
                      //  TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 20),
                  Consumer<BMIProvider>(
                    builder: (context, bmiProvider, child) {
                      if (bmiProvider.bmi == 0) return SizedBox();
                      return Column(
                        children: [
                          Text(
                            'Your BMI is:',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            bmiProvider.bmi.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFB76D68),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            bmiProvider.category,
                            style: TextStyle(
                              fontSize: 24,
                              color: _getCategoryColor(bmiProvider.category),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
