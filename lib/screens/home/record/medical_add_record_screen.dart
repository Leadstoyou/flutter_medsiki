import 'package:flutter/material.dart';
import 'package:untitled/screens/home/record/medical_record_menu_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalAddRecordScreen extends StatefulWidget {
  const MedicalAddRecordScreen({super.key});

  @override
  State<MedicalAddRecordScreen> createState() => _MedicalAddRecordScreenState();
}

class _MedicalAddRecordScreenState extends State<MedicalAddRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Cập nhật hồ sơ'),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Giới tính',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Manrope SemiBold'),
            ),
            SpacingHeight(18),
            Row(spacing: 35, children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: Color(0xFF990011))),
                  onPressed: () {},
                  child: Text(
                    'Nam',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Manrope SemiBold'),
                  )),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  backgroundColor: Color(0xFF990011),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  'Nữ',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Manrope SemiBold'),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: Color(0xFF990011))),
                  onPressed: () {},
                  child: Text(
                    'Khác',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Manrope SemiBold'),
                  )),
            ]),
            SpacingHeight(18),
            _inputField('Tuổi', new TextEditingController()),
            SpacingHeight(18),
            _inputField('Chiều cao', new TextEditingController()),
            SpacingHeight(18),
            _inputField('Cân nặng', new TextEditingController()),
            SpacingHeight(30),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 8),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: Color(0xFF990011))),
                  onPressed: () {
                    navigate(context, MedicalRecordMenuScreen());
                  },
                  child: Text(
                    'Lưu',
                    style: TextStyle(
                        color:  Color(0xFF990011),
                        fontSize: 20,
                        fontFamily: 'Manrope SemiBold'),
                  )),
            ),
          ],
        ),
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
            contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
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
