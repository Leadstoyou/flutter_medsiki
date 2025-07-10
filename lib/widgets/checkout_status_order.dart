import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/api/payos_api.dart';
import 'package:untitled/base/base._repository.dart';
import '../utils/local_storage.dart';

class CheckStatusOrder extends StatefulWidget {
  const CheckStatusOrder({
    super.key,
    required this.orderCode,
    required this.courseId,
    required this.coursePrice,
    required this.courseTitle,
  });
  final String orderCode;
  final String courseId;
  final String courseTitle;
  final String coursePrice;

  @override
  State<CheckStatusOrder> createState() => _CheckStatusOrder();
}

class _CheckStatusOrder extends State<CheckStatusOrder> {
  Timer? _timer;
  String? _status;
  bool _paymentCreated = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) => _checkStatus());
  }

  Future<void> _checkStatus() async {
    final result = await getOrder(widget.orderCode);
    if (result['error'] == 0) {
      final status = result['data']['status'];
      if (!mounted) return;

      setState(() {
        _status = status;
      });

      if (status == "PAID" || status == "CANCELLED") {
        if (status == "PAID" && !_paymentCreated) {
          final BaseRepository<Map<String, dynamic>> paymentsRepository =
          BaseRepository<Map<String, dynamic>>('payments');
          await paymentsRepository.create({
            'user': (await getUserFromLocalStorage())?.id,
            'orderAt': DateTime.now().toIso8601String(),
            'course': {
              'id': widget.courseId,
              'title': widget.courseTitle,
            },
            'paid': widget.coursePrice,
          });
          _paymentCreated = true; // Đánh dấu là đã tạo payment
        }

        _timer?.cancel();
        await Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            context.go(Uri(
              path: '/result',
              queryParameters: {
                "orderCode": widget.orderCode,
                "status": status,
              },
            ).toString());
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String displayText = "Đơn hàng đang chờ thanh toán";
    Widget icon = LoadingAnimationWidget.fourRotatingDots(
        color: Colors.purple.shade200, size: 25);

    if (_status == "PAID") {
      displayText = "Thanh toán đơn hàng thành công";
      icon = const Icon(Icons.check, color: Colors.green);
    } else if (_status == "CANCELLED") {
      displayText = "Đơn hàng đã bị hủy";
      icon = const Icon(Icons.close, color: Colors.red);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 10),
        DefaultTextStyle(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          child: Text(displayText),
        )
      ],
    );
  }
}