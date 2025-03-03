import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/auth/otp_verification_screen.dart';
import 'package:untitled/screens/auth/set_password_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/custom_input.dart';
import 'package:untitled/utils/email_sender.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/utils/util.dart';
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
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final BaseRepository<Map<String, dynamic>> _userRepository =
      BaseRepository<Map<String, dynamic>>('users');
  bool _isLoading = false;
  Future<void> register() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final mobile = _mobileController.text.trim();
    final dob = _dobController.text.trim();

    if (fullName.isEmpty || email.isEmpty || mobile.isEmpty || dob.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showToast(message: 'Vui lòng điền đầy đủ thông tin');
      return;
    }
    if (!isValidEmail(email)) {
      setState(() {
        _isLoading = false;
      });
      showToast(message: 'Email không hợp lệ');
      return;
    }

    if (!isValidPhoneNumber(mobile)) {
      setState(() {
        _isLoading = false;
      });
      showToast(message: 'Số điện thoại không hợp lệ');
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
      setState(() {
        _isLoading = false;
      });
      showToast(message: 'Tài khoản đã tồn tại');
      return;
    }
    showToast(message: 'Đang đăng ký');
    await sendOtpEmail(email);

    final result = await _userRepository.create(userData);

    if (result != null) {
      showToast(message: 'Gửi OTP Thành Công! Vui Lòng xác thực');

      navigate(context, OtpVerificationScreen(email: email , result : result));
    } else {
      showToast(message: 'Đăng ký thất bại. Vui lòng thử lại.');
    }
    setState(() {
      _isLoading = false;
    });
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  ElevatedButton(
                    onPressed: () async {
                      final GoogleSignInAccount? googleUser =
                      await _googleSignIn.signIn();
                      if (googleUser != null) {
                        final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;

                        var foundUser = (await _userRepository.search(
                            'email', googleUser.email)) ;
                        if (foundUser.isNotEmpty) {
                          MyUser foundMyUser =
                          MyUser.fromJson(castToMap(foundUser.first));
                          saveUserToLocalStorage(foundMyUser);
                          navigate(context, HomeScreen());
                        } else {
                          final userData = {
                            'fullName': googleUser.displayName,
                            'email': googleUser.email,
                            'mobile': "0123456789",
                            'dob': '01/01/1900',
                            'isActive' : true,
                          };
                          final result = await _userRepository.create(userData);

                          if (result != null) {
                            showToast(message: 'Đăng ký thành công!');
                            var foundUser = (await _userRepository.search(
                                'email', googleUser.email));
                            if (foundUser.isNotEmpty) {
                              MyUser foundMyUser =
                              MyUser.fromJson(castToMap(foundUser.first));
                              saveUserToLocalStorage(foundMyUser);
                              navigate(context, HomeScreen());
                            }
                          } else {
                            showToast(message: 'Đăng ký thất bại. Vui lòng thử lại.');
                          }
                        }
                      }
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
