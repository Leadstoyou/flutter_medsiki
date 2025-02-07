import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final BaseRepository<Map<String, dynamic>> _userRepository =
      BaseRepository<Map<String, dynamic>>('users');

  Future<void> _changePassword() async {
    if (_newPasswordController.text == _confirmPasswordController.text &&
        (await getUserFromLocalStorage())?.password ==
            _currentPasswordController.text) {
      _userRepository.update((await getUserFromLocalStorage())?.id ?? "",
          {'password': _newPasswordController.text});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đổi mật khẩu thành công!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mật khẩu xác nhận không khớp!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Đổi Mật Khẩu'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordField(
              'Mật khẩu hiện tại',
              _obscureCurrentPassword,
              (value) => setState(() => _obscureCurrentPassword = value),
              _currentPasswordController,
            ),
            _buildPasswordField(
              'Mật khẩu mới',
              _obscureNewPassword,
              (value) => setState(() => _obscureNewPassword = value),
              _newPasswordController,
            ),
            _buildPasswordField(
              'Xác nhận mật khẩu mới',
              _obscureConfirmPassword,
              (value) => setState(() => _obscureConfirmPassword = value),
              _confirmPasswordController,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _changePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Đổi Mật Khẩu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool obscureText,
      ValueChanged<bool> onObscureTap, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFFFD1D6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                onObscureTap(!obscureText);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
