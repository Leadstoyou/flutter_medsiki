import 'package:flutter/material.dart';
import 'package:untitled/screens/home/record/medical_record_allergies_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalRecordMenuScreen extends StatefulWidget {
  const MedicalRecordMenuScreen({super.key});

  @override
  State<MedicalRecordMenuScreen> createState() =>
      _MedicalRecordMenuScreenState();
}

class _MedicalRecordMenuScreenState extends State<MedicalRecordMenuScreen> {
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
            color: Color(0xFF990011),
            padding: EdgeInsets.fromLTRB(0, 16, 0, 30),
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
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          'Giới tính',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                        Text(
                          'Nữ',
                          style: TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          'Chiều cao',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                        Text(
                          '1m7',
                          style: TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                      ],
                    ),
                  ],
                ),
                SpacingHeight(5),
                Divider(
                  height: 0.5,
                  color: Color(0xFFFFD1D6),
                ),
                SpacingHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          'Tuổi',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                        Text(
                          '26',
                          style: TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        Text(
                          'Cân nặng',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                        Text(
                          '65kg',
                          style: TextStyle(
                              color: Color(0xFF990011),
                              fontSize: 18,
                              fontFamily: 'Manrope Semibold'),
                        ),
                      ],
                    ),
                  ],
                ),
                SpacingHeight(5),
                Divider(
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
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigate(context, MedicalRecordAllergiesScreen());
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
                )
              ],
            ),
          ),
        ],
      )),
      bottomNavigationBar: buildBottomNavigationBar(context, 2),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  Widget _inputField(String title, TextEditingController controller,
      {bool isDate = false, bool isEmail = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Manrope SemiBold',
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: isDate,
          enabled: !isEmail,
          onTap: isDate ? () => _selectDate(context) : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFD1D6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            suffixIcon: isDate
                ? const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF93000A),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
