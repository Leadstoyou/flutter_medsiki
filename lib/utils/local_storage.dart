import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/auth/welcome_screen.dart';
import 'package:untitled/screens/onboarding/onboarding_screen.dart';


Future<void> saveUserToLocalStorage(MyUser user) async {
  final prefs =  await SharedPreferences.getInstance();
  prefs.setString('user',jsonEncode(user));
}
Future<MyUser?> getUserFromLocalStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final userString = prefs.getString('user');
  if (userString != null) {
    final userMap = Map<String, dynamic>.from(jsonDecode(userString));
    return MyUser.fromJson(userMap);
  } else {
    return null;
  }
}
Future<void> deleteUser() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userKey = 'user';
    if (prefs.containsKey(userKey)) {
      await prefs.remove(userKey);
      print('Đã xóa dữ liệu user: $userKey');
    } else {
      print('Không tìm thấy dữ liệu của user: $userKey');
    }
  } catch (e) {
    print('Lỗi khi xóa user: $e');
  }
}
Future<void> checkFirstTime(BuildContext  context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('first_time') ?? false;
  await Future.delayed(const Duration(seconds: 3));
  Widget redirectScreen;

  if (isFirstTime) {
    await prefs.setBool('first_time', false);
    redirectScreen = OnboardingFirstScreen();
  } else {
    redirectScreen = WelcomeScreen();
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => redirectScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}
