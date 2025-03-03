import 'package:flutter/material.dart';
import 'package:untitled/screens/auth/set_password_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/email_sender.dart';
import 'package:untitled/widgets/common.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String result;
  final String email;
  const OtpVerificationScreen({required this.result,required this.email, Key? key}) : super(key: key);

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  void verifyOtp() {
    String enteredOtp = _otpController.text.trim();
    String? savedOtp = otpStorage[widget.email];

    if (enteredOtp == savedOtp) {
      showToast(message: '✅ Xác thực thành công!');
      navigate(context,  SetPasswordScreen(widget.result));
    } else {
      showToast(message: '❌ Mã OTP không chính xác!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Xác thực OTP',isBack: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nhập mã OTP',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Mã OTP đã được gửi đến email: ${widget.email}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, letterSpacing: 8),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Nhập OTP',

                hintStyle: const TextStyle(fontSize: 16, color: Colors.black38),
              ),
              maxLength: 4,
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF93000A),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Xác nhận',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
