import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/models/my_user.dart';
import 'package:untitled/screens/auth/welcome_screen.dart';
import 'package:untitled/screens/onboarding/onboarding_screen.dart';

final BaseRepository<Map<String, dynamic>> historiesRepository =
BaseRepository<Map<String, dynamic>>('histories');

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

Future<String> getUserWatchingVideoId() async{
  late String watchingVideoId;

  var listWatchingVideos = await historiesRepository.search('user', (await getUserFromLocalStorage())?.id ?? "");

  if (listWatchingVideos.isNotEmpty) {
    watchingVideoId = listWatchingVideos[0]['id'] ?? "";
  } else {
    watchingVideoId = "";
  }
  return watchingVideoId;
}
