import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:crypto/crypto.dart';

import '../repo/payment.dart';

String formatNumber(double value) {
  final f = new NumberFormat("#,###", "vi_VN");
  return f.format(value);
}

String formatDateTime(DateTime dateTime, String layout) {
  return DateFormat(layout).format(dateTime).toString();
}
String formatDateVN(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate).toLocal(); // Chuyển về giờ máy
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime); // 10/02/2025 03:53
}
bool isValidEmail(String email) {
  final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  return emailRegExp.hasMatch(email);
}

bool isValidPhoneNumber(String phone) {
  final phoneRegExp = RegExp(r"^(?:\+?84|0)([3|5|7|8|9])([0-9]{8})$");
  return phoneRegExp.hasMatch(phone);
}

int transIdDefault = 1;
String getAppTransId() {
  if (transIdDefault >= 100000) {
    transIdDefault = 1;
  }

  transIdDefault += 1;
  var timeString = formatDateTime(DateTime.now(), "yyMMdd_hhmmss");
  return sprintf("%s%06d",[timeString, transIdDefault]);
}

String getBankCode() => "zalopayapp";
String getDescription(String apptransid) => "Merchant Demo thanh toán cho đơn hàng  #$apptransid";

String getMacCreateOrder(String data) {
  var hmac =  new Hmac(sha256, utf8.encode(ZaloPayConfig.key1));
  return hmac.convert(utf8.encode(data)).toString();
}