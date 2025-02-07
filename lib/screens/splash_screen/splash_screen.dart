import 'package:flutter/material.dart';
import 'package:untitled/screens/onboarding/onboarding_screen.dart';
import 'package:untitled/utils/local_storage.dart';
import '../auth/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstTime(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFD1D6),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/first_screen_logo.png',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/logo_name.png',
              height: 100,
              width: 400,
            ),
          ],
        ),
      ),
    );
  }
}
