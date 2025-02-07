import 'package:flutter/material.dart';

Widget emptyWidget(BuildContext context) {
  return (Scaffold(
      backgroundColor: Color(0xFFFFD1D6),
      appBar: AppBar(
        backgroundColor: Color(0xFF990011),
        elevation: 0,
        title: const Text(
          'Thông tin',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 70, 16, 0),
        child: Column(spacing: 22, children: [
          Image.asset(
            'assets/images/empty_logo.png',
            width: 250,
          ),
          Text(
            'Chưa có tính năng này',
            style: TextStyle(
                fontSize: 26,
                fontFamily: 'Manrope SemiBold'),
          ),
          Center(
            child: Text(
              'Chúng tôi đang phát triển tính năng, xin vui lòng quay lại sau. Trân trọng cảm ơn.',
              style: TextStyle(
                color: Color(0xFF999293),
                  fontSize: 18,
                  fontFamily: 'Manrope SemiBold',
              ),
              textAlign: TextAlign.center
            ),
          )
        ]),
      )));
}
