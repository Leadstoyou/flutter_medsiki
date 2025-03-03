import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
class HomeOnboardingDetailScreen extends StatefulWidget {
  final dynamic course;

  const HomeOnboardingDetailScreen(this.course, {super.key});

  @override
  State<HomeOnboardingDetailScreen> createState() =>
      _HomeOnboardingDetailScreenState();
}

class _HomeOnboardingDetailScreenState
    extends State<HomeOnboardingDetailScreen> {
  get course => widget.course;
  final BaseRepository<Map<String, dynamic>> paymentsRepository =
      BaseRepository<Map<String, dynamic>>('payments');
  final BaseRepository<Map<String, dynamic>> historiesRepository =
      BaseRepository<Map<String, dynamic>>('histories');
  bool isButtonEnable = true;
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(int money) async {
    try {
      setState(() {
        isButtonEnable = !isButtonEnable;
      });
      paymentIntent = await createPaymentIntent((money / 25000 * 100).toInt().toString(), "usd");

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
        SnackBar(content: Center(child: Text("Thanh toán thành công!"))),
      );
      setState(() {
        isButtonEnable = !isButtonEnable;
      });
      return true;
    } catch (e) {
      setState(() {
        isButtonEnable = !isButtonEnable;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text("Lỗi thanh toán"))),
      );
      return false;
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
      appBar: buildCommonAppBar(context, 'Khóa học'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            SizedBox(height: 18),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 250,
                ),
                child: Text(
                  course['title'],
                  style: TextStyle(fontFamily: 'Manrope Medium', fontSize: 22),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xFF990011),
                  ))
            ]),
            SizedBox(height: 18),
            Row(
              spacing: 8,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF990011),
                ),
                Text('Địa Điểm',
                    style: TextStyle(
                        fontFamily: "Manrope Regular",
                        color: Color(0xFF818898),
                        fontSize: 14)),
                Text('Thời gian',
                    style: TextStyle(
                        fontFamily: "Manrope Regular",
                        color: Color(0xFF818898),
                        fontSize: 14))
              ],
            ),
            SizedBox(height: 18),
            Row(
              spacing: 25,
              children: [
                Text('Giá',
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Manrope SemiBold')),
                Text(
                    "${NumberFormat.currency(locale: 'vi_VN', symbol: '').format(course['price'])}₫",
                    style: TextStyle(
                        fontSize: 16, fontFamily: 'Manrope SemiBold')),
              ],
            ),
            SizedBox(height: 18),
            Text('Mô tả',
                style: TextStyle(fontSize: 16, fontFamily: 'Manrope SemiBold')),
            SizedBox(height: 18),
            Text(
              course['description'],
              style: TextStyle(fontSize: 16, fontFamily: 'Manrope '),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 55),
                child: ElevatedButton(

                  onPressed: isButtonEnable ?  () async {
                    if(await makePayment(course['price'])){
                      await paymentsRepository.create({
                        'user': (await getUserFromLocalStorage())?.id,
                        'orderAt': DateTime.now().toIso8601String(),
                        'course': {
                          'id' : course['id'],
                          'title' :course['title']
                        },
                        'paid': course['price']
                      });
                      navigate(context, HomeScreen());
                    }
                  } : null ,
                  style: ButtonStyle(
                      minimumSize:
                          WidgetStateProperty.all(Size(double.infinity, 60)),
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xFF990011)),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)))),
                  child: Text(
                    'Đăng Ký',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Manrope SemiBold',
                        color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
