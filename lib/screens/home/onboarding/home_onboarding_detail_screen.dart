import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/account_created_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../api/payos_api.dart';

class HomeOnboardingDetailScreen extends StatefulWidget {
  final dynamic course;

  const HomeOnboardingDetailScreen(this.course, {super.key});

  @override
  State<HomeOnboardingDetailScreen> createState() =>
      _HomeOnboardingDetailScreenState();
}

class _HomeOnboardingDetailScreenState
    extends State<HomeOnboardingDetailScreen> {
  late final dynamic course = widget.course;
  final BaseRepository<Map<String, dynamic>> paymentsRepository =
      BaseRepository<Map<String, dynamic>>('payments');
  final BaseRepository<Map<String, dynamic>> historiesRepository =
      BaseRepository<Map<String, dynamic>>('histories');
  bool isButtonEnable = true;
  bool _isLoading = false;
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(int money) async {
    try {
      setState(() => _isLoading = true);

      var data = {
        "description": course['title'],
        "amount": course['price'],
        "returnUrl": "https://medsiki-management.vercel.app/result",
        "cancelUrl": "https://medsiki-management.vercel.app/result",
      };
      print("data :: $data");
      var res = await createPaymentLink(data);
      print("res :: $res");
      if (res["error"] != 0) {
        throw Exception("Gọi API thất bại. Vui lòng thử lại sau!");
      }

      final String amount = res["data"]["amount"].toString();
      String orderCode = res["data"]["orderCode"].toString();
      final String accountNumber = res["data"]["accountNumber"].toString();
      final String accountName = res["data"]["accountName"].toString();
      final String description = res["data"]["description"].toString();
      final String qrCode = res["data"]["qrCode"].toString();
      final String bin = res["data"]["bin"].toString();

      if (!mounted) return false;

      if (!context.mounted) return false;
      context.go(Uri(
        path: '/payment',
        queryParameters: {
          "amount": amount,
          "orderCode": orderCode,
          "accountNumber": accountNumber,
          "accountName": accountName,
          "description": description,
          "qrCode": qrCode,
          "bin": bin,
          "courseId": course["id"]
        },
      ).toString());

      return true;
    } catch (e) {
      if (!mounted) return false;

      if (!context.mounted) return false;
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Đóng"),
              ),
            ],
          );
        },
      );
      return false;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCommonAppBar(context, 'Khóa học'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.memory(
                base64ToBytes(course['thumbnail']),
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text(
                    course['title'],
                    style: const TextStyle(
                      fontFamily: 'Manrope Medium',
                      fontSize: 22,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xFF990011),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: const [
                Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF990011),
                ),
                SizedBox(width: 8),
                Text(
                  'Địa Điểm',
                  style: TextStyle(
                    fontFamily: "Manrope Regular",
                    color: Color(0xFF818898),
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Thời gian',
                  style: TextStyle(
                    fontFamily: "Manrope Regular",
                    color: Color(0xFF818898),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Giá',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Manrope SemiBold',
                  ),
                ),
                Text(
                  "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(course['price'])}₫",
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Manrope SemiBold',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Mô tả',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Manrope SemiBold',
              ),
            ),
            const SizedBox(height: 18),
            Text(
              course['description'],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Manrope',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: ElevatedButton(
                onPressed: (isButtonEnable && !_isLoading)
                    ? () async {
                        final paymentSuccess =
                            await makePayment(course['price']);
                        // if (paymentSuccess && mounted) {
                        //   await paymentsRepository.create({
                        //     'user': (await getUserFromLocalStorage())?.id,
                        //     'orderAt': DateTime.now().toIso8601String(),
                        //     'course': {
                        //       'id': course['id'],
                        //       'title': course['title'],
                        //     },
                        //     'paid': course['price'],
                        //   });
                        //   if (mounted) {
                        //     navigate(context, const HomeScreen());
                        //   }
                        // }
                      }
                    : null,
                style: ButtonStyle(
                  minimumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 60)),
                  backgroundColor:
                      WidgetStateProperty.all(const Color(0xFF990011)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Đăng Ký',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Manrope SemiBold',
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
