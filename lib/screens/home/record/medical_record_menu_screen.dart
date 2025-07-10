import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/home/record/medical_record_allergies_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalRecordMenuScreen extends StatefulWidget {
  const MedicalRecordMenuScreen({super.key});

  @override
  State<MedicalRecordMenuScreen> createState() => _MedicalRecordMenuScreenState();
}

class _MedicalRecordMenuScreenState extends State<MedicalRecordMenuScreen> {
  String? _gender;
  String? _age;
  String? _height;
  String? _weight;

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
              width: double.infinity,
              color: const Color(0xFF990011),
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 30),
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFF990011),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SpacingHeight(5),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFFFFD1D6),
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
                  SpacingHeight(5),
                  const Divider(
                    height: 0.5,
                    color: Color(0xFFFFD1D6),
                  ),
                  SpacingHeight(30),
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigate(context, const MedicalRecordAllergiesScreen());
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/images/medical_record_di_ung.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/medical_record_xet_nghiem.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/medical_record_vaccine.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              'assets/images/medical_record_benh_nen.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
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