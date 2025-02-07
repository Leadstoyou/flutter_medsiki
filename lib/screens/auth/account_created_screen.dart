import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';

import '../../models/my_user.dart';

class AccountCreatedScreen extends StatelessWidget  {
  final dynamic result;
  const AccountCreatedScreen(this.result, {super.key});

  @override
  Widget build(BuildContext context) {
    final BaseRepository<Map<String, dynamic>> userRepository =
    BaseRepository<Map<String, dynamic>>('users');
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Tạo Tài Khoản', isBack: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Checkmark with confetti effect
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/checkmark.png', // Replace with your image path
                  width: 300, // Adjust size as needed
                  height: 300,
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Chúc Mừng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF93000A),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Bạn đã tạo tài khoản thành công!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                final user = await  userRepository.findById(result, MyUser.fromJson);
                await saveUserToLocalStorage(user!);
              navigate(context, HomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF93000A),
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text(
                'Trang chủ',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
