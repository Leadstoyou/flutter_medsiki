import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/register_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';

import '../../models/my_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final BaseRepository<Map<String, dynamic>> userRepository =
      BaseRepository<Map<String, dynamic>>('users');

  Future<void> _loginUser() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        var foundUser = (await userRepository.search('email', email)).first;
        MyUser foundMyUser = MyUser.fromJson(castToMap(foundUser));
        if (foundMyUser.password == password) {
          saveUserToLocalStorage(foundMyUser);
          navigate(context, HomeScreen());
        } else {
          Fluttertoast.showToast(
            msg: 'Không tìm thấy người dùng với email và mật khẩu đã nhập!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print('No user found with that email and password.');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Đăng Nhập'),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chào mừng\nđến với',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: 'Manrope'),
                ),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 70,
                    ),
                    Positioned(
                      top: -15,
                      left: -90,
                      child: Image.asset(
                        'assets/images/logo_name.png',
                        height: 70,
                        width: 300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Email hoặc Số điện thoại',
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'League Spartan SemiBold'),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFFD1D6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Mật Khẩu',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'League Spartan SemiBold'),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscureText,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFFFD1D6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle "Forgot Password" press
                    },
                    child: const Text(
                      'Quên Mật Khẩu',
                      style: TextStyle(
                        color: Color(0xFF990011),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _loginUser, // Call the login function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF93000A),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Manrope',
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
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
                      'Hoặc đăng nhập bằng',
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
                      onPressed: () async {
                        final GoogleSignInAccount? googleUser =
                            await _googleSignIn.signIn();
                        if (googleUser != null) {
                          final GoogleSignInAuthentication googleAuth =
                              await googleUser.authentication;
                    
                          print('User Name: ${googleUser.displayName}');
                          print('User Email: ${googleUser.email}');
                          print('Access Token: ${googleAuth.accessToken}');
                          print('ID Token: ${googleAuth.idToken}');
                          var foundUser = (await userRepository.search(
                                  'email', googleUser.email)).first;
                          if (foundUser.isNotEmpty) {
                            MyUser foundMyUser =
                                MyUser.fromJson(castToMap(foundUser));
                            saveUserToLocalStorage(foundMyUser);
                            navigate(context, HomeScreen());
                          } else {
                            final userData = {
                              'fullName': googleUser.displayName,
                              'email': googleUser.email,
                              'mobile': 0123456789,
                              'dob': '01/01/1900',
                            };
                            final result = await userRepository.create(userData);
                    
                            if (result != null) {
                              showToast(message: 'Đăng ký thành công! , Mời đăng nhập lại');
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
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      navigate(context, RegisterScreen());
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Bạn chưa có tài khoản? ',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Manrope Regular',
                            fontSize: 16),
                        children: [
                          TextSpan(
                            text: 'Đăng Ký',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
