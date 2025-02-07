import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const CircleIcon({
    Key? key,
    required this.icon,
    this.color = Colors.pink,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        size: size * 0.6, // Điều chỉnh kích thước icon
        color: Colors.white, // Màu của icon
      ),
    );
  }
}