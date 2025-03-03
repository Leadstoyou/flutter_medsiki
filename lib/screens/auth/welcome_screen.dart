import 'package:flutter/material.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/auth/login_screen.dart';
import 'package:untitled/screens/auth/register_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isLoading = true; // Trạng thái loading
  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final user = await getUserFromLocalStorage();
    if (user != null) {
      navigate(context, HomeScreen());
    }else {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Hiển thị vòng tròn loading
            :  Padding(
          padding: const EdgeInsets.fromLTRB(20.0,150,20,20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/first_screen_logo_2.png',
                height: 180,
                width: 180,
              ),
              Image.asset(
                'assets/images/logo_name.png',
                height: 100,
                width: 400,
              ),
              const SizedBox(height: 20),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                'sed do eiusmod tempor incididunt ut labore et dolore '
                'magna aliqua.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'League Spartan',
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 40),
              // Login Button
              SizedBox(
                width: 225,
                child: ElevatedButton(
                  onPressed: () {
                    navigate(
                      context,
                      LoginScreen(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF93000A),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w900,
                        fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Register Button
              SizedBox(
                width: 225,
                child: ElevatedButton(
                  onPressed: () {
                    navigate(
                      context,
                      RegisterScreen(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD1D6),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w900,
                        fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
