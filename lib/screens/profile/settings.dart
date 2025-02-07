import 'package:flutter/material.dart';
import 'package:untitled/screens/profile/change_password.dart';
import 'package:untitled/screens/profile/notification_setting.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/widgets/common.dart';
import 'package:untitled/widgets/menu_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Cài Đặt'),
      body: SingleChildScrollView(
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildMenuItem('Thông báo', Icons.notifications, () {
              navigate(context, NotificationSettingsScreen());
            }),
            buildMenuItem('Mật khẩu', Icons.key, () {   navigate(context, ChangePasswordScreen());}),
            buildMenuItem('Xóa tài khoản', Icons.person, () {}),
          ],
        ),
      ),
    );
  }


}