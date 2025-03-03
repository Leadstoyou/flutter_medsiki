import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/utils/common.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({required this.token, Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final BaseRepository<Map<String, dynamic>> _userRepository =
  BaseRepository<Map<String, dynamic>>('users');

  Future<void> resetPassword() async {
    final newPassword = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      showToast(message: 'Vui lòng nhập mật khẩu');
      return;
    }
    if (newPassword != confirmPassword) {
      showToast(message: 'Mật khẩu không khớp');
      return;
    }

    final email = await verifyResetToken(widget.token);
    if (email == null) {
      showToast(message: '❌ Token không hợp lệ!');
      return;
    }

    _userRepository.update(email, {'password': newPassword});

    showToast(message: '✅ Đổi mật khẩu thành công!');
    Navigator.pop(context); // Quay lại màn hình đăng nhập
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đặt lại mật khẩu')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập mật khẩu mới',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu mới',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Xác nhận mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: resetPassword,
                child: const Text('Xác nhận'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
