import 'package:flutter/material.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalRecordAllergiesScreen extends StatefulWidget {
  const MedicalRecordAllergiesScreen({super.key});

  @override
  State<MedicalRecordAllergiesScreen> createState() =>
      _MedicalRecordMenuScreenState();
}

class _MedicalRecordMenuScreenState
    extends State<MedicalRecordAllergiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildCommonAppBar(context, 'Hồ sơ y tế'),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  'Nguyen',
                  style: TextStyle(
                      color: Color(0xFF990011),
                      fontSize: 28,
                      fontFamily: 'Manrope Semibold'),
                )),
                SpacingHeight(10),
                Divider(
                  height: 0.5,
                  color: Color(0xFFFFD1D6),
                ),
                SpacingHeight(10),
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
                SpacingHeight(20),
                Divider(
                  height: 0.5,
                  color: Color(0xFFFFD1D6),
                ),
                SpacingHeight(15),
                Text(
                  'Dị Ứng',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'Manrope Semibold'),
                ),
                SpacingHeight(20),
                Divider(
                  height: 0.5,
                  color: Color(0xFFFFD1D6),
                ),
                SpacingHeight(20),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF990011)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1, // Phần chiếm 1
                        child: Icon(Icons.circle_outlined,color: Color(0xFF990011),),
                      ),
                      Expanded(
                        flex: 11, // Phần chiếm 11
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Insulin',style: TextStyle(color: Color(0xFF990011),fontSize: 22,fontFamily: 'Manrope SemiBold'),)
                          ],
                        ),
                      ),
                    ],
                  )
                  ,
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
