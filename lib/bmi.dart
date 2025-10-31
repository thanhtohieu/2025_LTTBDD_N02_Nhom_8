import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

/// Root widget of the BMI Calculator app.
/// Sets up the Material theme and starts the main BMI screen.
class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const BMIScreen(),
    );
  }
}

/// Main screen for BMI calculation.
/// Users can enter their height and weight, then calculate BMI.
class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _bmiCategory = '';

  /// Calculates BMI based on height (cm) and weight (kg).
  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    final double heightInMeters = height / 100;
    final double bmi = weight / (heightInMeters * heightInMeters);

    String category;
    if (bmi < 18.5) {
      category = 'Underweight';
    } else if (bmi < 24.9) {
      category = 'Normal';
    } else if (bmi < 29.9) {
      category = 'Overweight';
    } else {
      category = 'Obese';
    }

    setState(() {
      _bmi = bmi;
      _bmiCategory = category;
    });
  }

  /// Returns color based on BMI category for better visual feedback.
  Color _getBMICategoryColor() {
    switch (_bmiCategory) {
      case 'Underweight':
        return Colors.orange;
      case 'Normal':
        return Colors.green;
      case 'Overweight':
        return Colors.amber;
      case 'Obese':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🖼️ Ảnh minh họa BMI (đặt ở trên tiêu đề)
            Image.asset(
              'imgs/BMICal.png', // đường dẫn ảnh
              height: 250,
              fit: BoxFit.cover,
              
            ),
            const SizedBox(height: 20),

            // Tiêu đề
            const Text(
              'Enter your details',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),


            // Height input
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (cm)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 20),

            // Weight input
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.monitor_weight),
              ),
            ),
            const SizedBox(height: 30),

            // Calculate button
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Calculate BMI',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 40),

            // Result display
            if (_bmi != null)
              Column(
                children: [
                  Text(
                    'Your BMI: ${_bmi!.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: _getBMICategoryColor(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Category: $_bmiCategory',
                    style: TextStyle(
                      fontSize: 20,
                      color: _getBMICategoryColor(),
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
