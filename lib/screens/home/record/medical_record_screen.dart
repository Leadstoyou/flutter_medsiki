import 'package:flutter/material.dart';
import 'package:untitled/screens/home/record/medical_add_record_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF93000A),
        title: const Text(
          'Hồ sơ y tế',
          style: TextStyle(color: Colors.white, fontFamily: 'Manrope SemiBold'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'assets/images/medical_record_logo.png',
              height: 400,
              width: 200,
            )),
            SizedBox(
              height: 8,
            ),
            Text('hãy cho chúng tôi biết thêm về tình trạng sức khỏe của bạn'),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      side: BorderSide(color: Color(0xFF990011))),
                  child: Text(
                    'Để sau',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Manrope SemiBold'),
                  ),
                ) ,  ElevatedButton(
                  onPressed: () {
                    navigate(context, MedicalAddRecordScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
                      backgroundColor: Color(0xFF990011),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                     ),
                  child: Text(
                    'Cập Nhật',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Manrope SemiBold'),
                  ),
                )
              ],
            )
          ],
        ),
      )),
      bottomNavigationBar: buildBottomNavigationBar(context, 2),
    );
  }
}
