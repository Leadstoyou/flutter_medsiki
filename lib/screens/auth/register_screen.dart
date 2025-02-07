import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/set_password_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/custom_input.dart';
import 'package:untitled/widgets/common.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final BaseRepository<Map<String, dynamic>> _userRepository =
      BaseRepository<Map<String, dynamic>>('users');

  Future<void> register() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final mobile = _mobileController.text.trim();
    final dob = _dobController.text.trim();

    if (fullName.isEmpty || email.isEmpty || mobile.isEmpty || dob.isEmpty) {
      showToast(message: 'Vui lòng điền đầy đủ thông tin');
      return;
    }

    final userData = {
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'dob': dob,
    };
    final currentUser = await _userRepository.search('email', email);
    if (currentUser!.isNotEmpty) {
      showToast(message: 'Tài khoản đã tồn tại');
      return;
    }
    final result = await _userRepository.create(userData);

    if (result != null) {
      showToast(message: 'Đăng ký thành công!');
      navigate(context, SetPasswordScreen(result));
    } else {
      showToast(message: 'Đăng ký thất bại. Vui lòng thử lại.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Đăng Ký'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _registerText('Full name'),
              SpacingHeight(10),
              CustomInput(controller: _fullNameController),
              SpacingHeight(20),
              _registerText('Email'),
              SpacingHeight(10),
              CustomInput(controller: _emailController),
              SpacingHeight(20),
              _registerText('Mobile Number'),
              SpacingHeight(10),
              CustomInput(controller: _mobileController),
              SpacingHeight(20),
              _registerText('Date Of Birth'),
              SpacingHeight(10),
              CustomInput(
                controller: _dobController,
                hintText: 'DD / MM / YYYY',
                readOnly: true,
                suffixIcon: Icons.calendar_today,
                onTap: () => selectDate(
                  context: context,
                  controller: _dobController,
                ),
              ),
              SpacingHeight(30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: const Text.rich(
                    TextSpan(
                      text: 'Để tiếp tục,bạn đồng ý với\n ',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Manrope Regular',
                          fontSize: 16),
                      children: [
                        TextSpan(
                          text: 'Điều khoản',
                          style: TextStyle(
                            color: Color(0xFF990011),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' và ',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Manrope Regular',
                              fontSize: 16),
                        ),
                        TextSpan(
                          text: 'Chính sách',
                          style: TextStyle(
                            color: Color(0xFF990011),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF93000A),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Manrope Medium',
                        fontWeight: FontWeight.w500,
                        fontSize: 22),
                  ),
                ),
              ),
        
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                      endIndent: 10,
                    ),
                  ),
                  const Text(
                    'Hoặc đăng ký bằng',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF262626),
                      fontFamily: 'Manrope Regular',
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: 'Đang phát triển',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      side: const BorderSide(
                        color: Color(0xFF990011),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/facebook_logo.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'Facebook',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Google login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      side: const BorderSide(
                        color: Color(0xFF990011),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Image.asset('assets/images/google_logo.png'),
                        const SizedBox(width: 10),
                        const Text(
                          'Google',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 20, fontFamily: 'League Spartan SemiBold'),
    );
  }
}
