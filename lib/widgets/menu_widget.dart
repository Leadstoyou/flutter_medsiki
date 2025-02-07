import 'package:flutter/material.dart';

Widget buildMenuItem(String title, IconData icon, VoidCallback onTap,
    {Widget? leadingIcon}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Color(0xFF990011),
      child: leadingIcon != null
          ? leadingIcon
          : Icon(
              icon,
              color: Colors.white,
            ),
    ),
    title: Text(
      title,
      style: TextStyle(fontFamily: 'Manrope Medium', fontSize: 20),
    ),
    trailing: const Icon(
      Icons.arrow_forward_ios,
      color: Color(0xFF990011),
    ),
    onTap: onTap,
  );
}
