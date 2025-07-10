import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalRecordAllergiesScreen extends StatefulWidget {
  const MedicalRecordAllergiesScreen({super.key});

  @override
  State<MedicalRecordAllergiesScreen> createState() => _MedicalRecordAllergiesScreenState();
}

class _MedicalRecordAllergiesScreenState extends State<MedicalRecordAllergiesScreen> {
  String? _gender;
  String? _age;
  String? _height;
  String? _weight;
  String? _name;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _gender = prefs.getString('gender') ?? 'Chưa cập nhật';
      _age = prefs.getString('age') ?? 'Chưa cập nhật';
      _height = prefs.getString('height') ?? 'Chưa cập nhật';
      _weight = prefs.getString('weight') ?? 'Chưa cập nhật';
      _name = prefs.getString('name') ?? 'Chưa cập nhật'; // Giả sử có lưu tên
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCommonAppBar(context, 'Hồ sơ y tế'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      _name ?? 'Chưa cập nhật',
                      style: const TextStyle(
                        color: Color(0xFF990011),
                        fontSize: 28,
                        fontFamily: 'Manrope Semibold',
                      ),
                    ),
                  ),
                  SpacingHeight(10),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFFFFD1D6),
                  ),
                  SpacingHeight(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Giới tính',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _gender ?? 'Chưa cập nhật',
                            style: const TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Chiều cao',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _height ?? 'Chưa cập nhật',
                            style: const TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SpacingHeight(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Tuổi',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _age ?? 'Chưa cập nhật',
                            style: const TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Cân nặng',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _weight ?? 'Chưa cập nhật',
                            style: const TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SpacingHeight(20),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFFFFD1D6),
                  ),
                  SpacingHeight(15),
                  const Text(
                    'Dị Ứng',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'Manrope Semibold',
                    ),
                  ),
                  SpacingHeight(20),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFFFFD1D6),
                  ),
                  SpacingHeight(20),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF990011)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.circle_outlined,
                            color: Color(0xFF990011),
                          ),
                        ),
                        Expanded(
                          flex: 11,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Insulin',
                                style: TextStyle(
                                  color: Color(0xFF990011),
                                  fontSize: 22,
                                  fontFamily: 'Manrope SemiBold',
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 2),
    );
  }
}