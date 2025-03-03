import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/forgot_password_otp.dart';
import 'package:untitled/utils/email_sender.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final BaseRepository<Map<String, dynamic>> userRepository =
  BaseRepository<Map<String, dynamic>>('users');

  Future<void> sendResetLink() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      showToast(message: '❌ Vui lòng nhập email!');
      return;
    }

    var user = await userRepository.search('email', email);
    if (user.isNotEmpty) {
      showToast(message: '📩 Đang gửi Email...');
      await sendOtpForgotEmail(email);
      showToast(message: '🔗 Link khôi phục đã được gửi đến email của bạn!');
      navigate(context, ForgotPasswordOtpScreen(email: email));
    } else {
      showToast(message: '⚠️ Tài khoản không tồn tại!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Quên mật khẩu', isBack: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập email của bạn để nhận link khôi phục mật khẩu',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Nhập email',
                prefixIcon: const Icon(Icons.email, color: Colors.black54),
                hintStyle: const TextStyle(fontSize: 16, color: Colors.black38),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: sendResetLink,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Gửi yêu cầu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
