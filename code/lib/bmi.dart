import 'package:flutter/material.dart';

void main() => runApp(const BMICalculatorApp());

/// Root widget that defines the app and its theme.
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

/// Main BMI screen with language toggle and BMI calculation logic.
class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() =>
      _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController =
      TextEditingController();
  final TextEditingController _weightController =
      TextEditingController();

  double? _bmi;
  String _bmiCategory = '';
  bool _isEnglish = true;
  bool _isMetric = true;

  // MỚI: Thêm 2 biến state để lưu ảnh và cân nặng lý tưởng
  String _bmiImageAsset = '';
  String _idealWeightRange = '';

  /// Switches between English and Vietnamese.
  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;

      if (_bmi != null) {
        // CẬP NHẬT: Gọi hàm mới để cập nhật cả category và ảnh
        _updateBMICategoryAndImage(_bmi!);
      }
    });
  }

  /// CẬP NHẬT: Đổi tên và thêm logic gán ảnh
  void _updateBMICategoryAndImage(double bmi) {
    String category;
    String
    imageAsset; // MỚI: Biến tạm cho đường dẫn ảnh

    if (bmi < 18.5) {
      category = _isEnglish
          ? 'Underweight'
          : 'Thiếu cân';
      imageAsset = 'imgs/underweight.png'; // MỚI
    } else if (bmi < 24.9) {
      category = _isEnglish
          ? 'Normal'
          : 'Bình thường';
      imageAsset = 'imgs/normal.png'; // MỚI
    } else if (bmi < 29.9) {
      category = _isEnglish
          ? 'Overweight'
          : 'Thừa cân';
      imageAsset = 'imgs/overweight.png'; // MỚI
    } else {
      category = _isEnglish ? 'Obese' : 'Béo phì';
      imageAsset = 'imgs/obesity.png'; // MỚI
    }

    setState(() {
      _bmiCategory = category;
      _bmiImageAsset =
          imageAsset; // MỚI: Cập nhật state ảnh
    });
  }

  /// CẬP NHẬT: Tính BMI VÀ tính cân nặng lý tưởng
  void _calculateBMI() {
    final double? height = double.tryParse(
      _heightController.text,
    );
    final double? weight = double.tryParse(
      _weightController.text,
    );

    if (height == null ||
        weight == null ||
        height <= 0 ||
        weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEnglish
                ? 'Please enter valid numbers'
                : 'Vui lòng nhập số hợp lệ',
          ),
        ),
      );
      return;
    }

    double bmi;
    double
    heightInMeters; // MỚI: Khai báo ở ngoài để dùng chung

    if (_isMetric) {
      // --- Tính toán hệ Metric (kg/cm) ---
      heightInMeters =
          height / 100; // Gán giá trị
      bmi =
          weight /
          (heightInMeters * heightInMeters);
    } else {
      // --- Tính toán hệ Imperial (lbs/in) ---
      heightInMeters =
          height *
          0.0254; // MỚI: Chuyển inch sang mét
      bmi = (weight / (height * height)) * 703;
    }

    // MỚI: Tính khoảng cân nặng lý tưởng (dựa trên heightInMeters)
    // BMI lý tưởng: 18.5 - 24.9
    final double idealMinKg =
        18.5 * (heightInMeters * heightInMeters);
    final double idealMaxKg =
        24.9 * (heightInMeters * heightInMeters);
    String idealRangeString;

    if (_isMetric) {
      // Hiển thị dạng Kg
      idealRangeString =
          "${idealMinKg.toStringAsFixed(1)} kg - ${idealMaxKg.toStringAsFixed(1)} kg";
    } else {
      // Đổi Kg sang Lbs để hiển thị
      final double idealMinLbs =
          idealMinKg * 2.20462;
      final double idealMaxLbs =
          idealMaxKg * 2.20462;
      idealRangeString =
          "${idealMinLbs.toStringAsFixed(1)} lbs - ${idealMaxLbs.toStringAsFixed(1)} lbs";
    }

    // CẬP NHẬT: Gọi hàm mới
    _updateBMICategoryAndImage(bmi);

    setState(() {
      _bmi = bmi;
      _idealWeightRange =
          idealRangeString; // MỚI: Cập nhật state cân nặng
    });
  }

  Color _getBMICategoryColor() {
    switch (_bmiCategory) {
      case 'Underweight':
      case 'Thiếu cân':
        return Colors.orange;
      case 'Normal':
      case 'Bình thường':
        return Colors.green;
      case 'Overweight':
      case 'Thừa cân':
        return Colors.amber;
      case 'Obese':
      case 'Béo phì':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // GIỮ NGUYÊN: Hàm hiển thị thông tin nhóm của bạn
  void _showGroupInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            _isEnglish
                ? "Group Info"
                : "Thông tin nhóm",
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // === THÔNG TIN CỦA BẠN ===
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'imgs/thanh.jpg',
                    ),
                  ),
                  title: const Text(
                    "Đinh Thế Thành",
                  ),
                  subtitle: const Text(
                    "MSSV: 22010228",
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage(
                      'imgs/hoan.jpg',
                    ),
                  ),
                  title: const Text(
                    "Lê Chí Hoàn",
                  ),
                  subtitle: const Text(
                    "MSSV: 22010046",
                  ),
                ),
                // === KẾT THÚC PHẦN THÔNG TIN ===
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                _isEnglish ? "Close" : "Đóng",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // CẬP NHẬT: Thêm key mới cho cân nặng lý tưởng
    final t = _isEnglish
        ? {
            'title': 'BMI Calculator',
            'enterDetails': 'Enter your details',
            'height_cm': 'Height (cm)',
            'weight_kg': 'Weight (kg)',
            'height_in': 'Height (in)',
            'weight_lbs': 'Weight (lbs)',
            'metric': 'Metric (kg/cm)',
            'imperial': 'Imperial (lbs/in)',
            'calculate': 'Calculate BMI',
            'yourBmi': 'Your BMI',
            'category': 'Category',
            'idealWeight':
                'Ideal Weight Range', // MỚI
            'language': 'VN',
          }
        : {
            'title': 'Tính Chỉ Số Cơ Thể',
            'enterDetails':
                'Nhập thông tin của bạn',
            'height_cm': 'Chiều cao (cm)',
            'weight_kg': 'Cân nặng (kg)',
            'height_in': 'Chiều cao (in)',
            'weight_lbs': 'Cân nặng (lbs)',
            'metric': 'Hệ Mét (kg/cm)',
            'imperial': 'Hệ Anh (lbs/in)',
            'calculate': 'Tính BMI',
            'yourBmi': 'Chỉ số BMI của bạn',
            'category': 'Phân loại',
            'idealWeight':
                'Khoảng cân nặng lý tưởng', // MỚI
            'language': 'EN',
          };

    return Scaffold(
      appBar: AppBar(
        title: Text(t['title']!),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showGroupInfo,
            tooltip: _isEnglish
                ? 'Group Info'
                : 'Thông tin nhóm',
          ),
          IconButton(
            onPressed: _toggleLanguage,
            icon: Text(
              t['language']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            tooltip: _isEnglish
                ? 'Chuyển sang Tiếng Việt'
                : 'Switch to English',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                t['enterDetails']!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ToggleButtons(
                isSelected: [
                  _isMetric,
                  !_isMetric,
                ],
                onPressed: (index) {
                  setState(() {
                    _isMetric = index == 0;
                    _heightController.clear();
                    _weightController.clear();
                    _bmi = null;
                    _bmiCategory = '';
                    _bmiImageAsset =
                        ''; // MỚI: Reset ảnh
                    _idealWeightRange =
                        ''; // MỚI: Reset cân nặng
                  });
                },
                borderRadius:
                    BorderRadius.circular(8.0),
                selectedColor: Colors.white,
                fillColor: Colors.teal,
                color: Colors.teal,
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 140.0,
                ),
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                    child: Text(t['metric']!),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                    child: Text(t['imperial']!),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _heightController,
                keyboardType:
                    TextInputType.number,
                decoration: InputDecoration(
                  labelText:
                      t[_isMetric
                          ? 'height_cm'
                          : 'height_in']!,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(
                    Icons.height,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _weightController,
                keyboardType:
                    TextInputType.number,
                decoration: InputDecoration(
                  labelText:
                      t[_isMetric
                          ? 'weight_kg'
                          : 'weight_lbs']!,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(
                    Icons.monitor_weight,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding:
                      const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  t['calculate']!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // CẬP NHẬT: Phần hiển thị kết quả
              if (_bmi != null)
                Column(
                  children: [
                    Text(
                      '${t['yourBmi']!}: ${_bmi!.toStringAsFixed(1)}',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            _getBMICategoryColor(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${t['category']!}: $_bmiCategory',
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            _getBMICategoryColor(),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ), // MỚI: Tăng khoảng cách
                    // MỚI: Hàng chứa ảnh và cân nặng lý tưởng
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceEvenly,
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .center,
                      children: [
                        // Cột 1: Ảnh minh họa
                        if (_bmiImageAsset
                            .isNotEmpty)
                          Image.asset(
                            _bmiImageAsset,
                            height:
                                180, // Chỉnh kích thước
                            fit: BoxFit.contain,
                          ),

                        // Cột 2: Cân nặng lý tưởng (Dùng Expanded để không vỡ layout)
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(
                                  left: 20.0,
                                ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                Text(
                                  t['idealWeight']!, // Lấy text từ map
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .grey[700],
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  _idealWeightRange, // Hiển thị khoảng cân nặng
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                    color: Colors
                                        .green, // Màu xanh
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
