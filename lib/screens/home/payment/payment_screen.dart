import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent("100", "usd");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: "Medsiki",
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode: "VN",
            testEnv: true, // Bật chế độ test
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Thanh toán thành công!")),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi thanh toán: $e")),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    final response = await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      headers: {
        "Authorization": "Bearer sk_test_51QxKABQ2GPSXqnNu4G8yMsr9rDvNbT1XLKWlSKSCWhcTmCLM7ulbKckIOFGKssPf9fTkFvNBE6mjYbGpTtHVg3Ng00m7XOI1AN", // Thay bằng Secret Key
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        "amount": amount,
        "currency": currency,
        "payment_method_types[]": "card",
      },
    );

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thanh toán Stripe")),
      body: Center(
        child: ElevatedButton(
          onPressed: makePayment,
          child: Text("Thanh toán \$10"),
        ),
      ),
    );
  }
}
