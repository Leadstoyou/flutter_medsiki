import 'package:flutter/material.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/privacy_policy_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';

class SetPasswordScreen extends StatefulWidget {
  final dynamic result; // User ID passed from the previous screen

  const SetPasswordScreen(this.result, {Key? key}) : super(key: key);

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<SetPasswordScreen> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  late dynamic result;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final BaseRepository<Map<String, dynamic>> _userRepository =
  BaseRepository<Map<String, dynamic>>('users');

  @override
  void initState() {
    super.initState();
    result = widget.result; // Get the user ID from the previous screen
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Tạo Mật Khẩu', isBack: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText1,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFFE9EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText1 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Confirm Password',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _confirmPasswordController,
              obscureText: _obscureText2,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFFE9EC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final password = _passwordController.text.trim();
                  final confirmPassword = _confirmPasswordController.text.trim();

                  if (password.isEmpty || confirmPassword.isEmpty) {
                    showToast(message: 'Please enter both passwords');
                    return;
                  }

                  if (password != confirmPassword) {
                    showToast(message: 'Passwords do not match');
                    return;
                  }

                  _userRepository.update(result, {'password' : password});
                  showToast(message: 'Thành công!');
                  navigate(context, PivacyPolicyScreen(result));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Tạo mật khẩu',
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
