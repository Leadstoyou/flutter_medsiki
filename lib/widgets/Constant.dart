import 'dart:ui';

import 'package:flutter/material.dart';

class OrderStatus {
  static const String pending = "pending";
  static const String confirmed = "confirmed";
  static const String shipped = "shipped";
  static const String delivered = "delivered";
  static const String cancelled = "cancelled";
}
String getOrderStatusText(String status) {
  switch (status) {
    case 'pending': return "Chờ xác nhận";
    case 'confirmed': return "Đã xác nhận";
    case 'shipped': return "Đang giao hàng";
    case 'delivered': return "Đã giao hàng";
    case 'cancelled': return "Đã hủy";
    default: return "Không xác định";
  }
}
Color getOrderStatusColor(String status) {
  switch (status) {
    case 'pending': return Colors.orange;
    case 'confirmed': return Colors.blue;
    case 'shipped': return Colors.purple;
    case 'delivered': return Colors.green;
    case 'cancelled': return Colors.red;
    default: return Colors.black;
  }
}
