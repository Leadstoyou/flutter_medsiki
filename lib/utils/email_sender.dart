import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Map<String, String> otpStorage = {};
Map<String, String> otpForgotStorage = {};
Future<void> sendOtpEmail(String email) async {
  String username = 'trinhtiendat2510@gmail.com';
  String password = 'qxok oqkl veao ewom';


  final smtpServer = gmail(username, password);

  String otp = (1000 + Random().nextInt(9000)).toString();
  otpStorage[email] = otp;

  final message = Message()
    ..from = Address(username, 'Support Team')
    ..recipients.add(email)
    ..subject = 'Mã OTP của bạn'
    ..text = 'Mã OTP của bạn là: $otp\nVui lòng không chia sẻ với ai!';

  try {
    await send(message, smtpServer);
    print('✅ Email OTP đã được gửi!');
  } catch (e) {
    print('❌ Gửi email thất bại: $e');
  }
}

Future<void> sendOtpForgotEmail(String email) async {
  String username = 'trinhtiendat2510@gmail.com';
  String password = 'qxok oqkl veao ewom';


  final smtpServer = gmail(username, password);

  String otp = (1000 + Random().nextInt(9000)).toString();
  otpForgotStorage[email] = otp;

  final message = Message()
    ..from = Address(username, 'Support Team')
    ..recipients.add(email)
    ..subject = 'Mã OTP quên mật khẩu của bạn'
    ..text = 'Mã OTP  quên mật khẩu của bạn là: $otp\nVui lòng không chia sẻ với ai!';

  try {
    await send(message, smtpServer);
    print('✅ Email OTP đã được gửi!');
  } catch (e) {
    print('❌ Gửi email thất bại: $e');
  }
}
