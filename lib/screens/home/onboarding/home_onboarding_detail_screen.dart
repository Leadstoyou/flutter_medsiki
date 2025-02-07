import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/screens/auth/account_created_screen.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/screens/store/product_info_screen.dart';
import 'package:untitled/utils/common.dart';
import 'package:untitled/utils/local_storage.dart';
import 'package:untitled/widgets/common.dart';

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
                  onPressed: () async {
                    await paymentsRepository.create({
                      'user': (await getUserFromLocalStorage())?.id,
                      'orderAt': DateTime.now().toIso8601String(),
                      'course': course['id'],
                      'paid': course['price']
                    });
                    // var list = await historiesRepository.search(
                    //     'user', (await getUserFromLocalStorage())!.id ?? "");
                    // if (list.isEmpty) {
                    //   var data = await historiesRepository.create({
                    //     'user': (await getUserFromLocalStorage())!.id ?? "",
                    //     'courses': {
                    //       course['id']: {
                    //         'isPaid': true,
                    //       }
                    //     }
                    //   });
                    // } else {
                    //   print(list[0]['courses']);
                    //   var a = list[0]['courses'];
                    //   if (a[course['id']] == null) {
                    //     a[course['id']] = {};
                    //   }
                    //   a[course['id']]['isPaid'] = true;
                    //   list[0].update('courses', (_) => a);
                    // }

                    Fluttertoast.showToast(
                      msg: 'Thanh toán thành công',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    navigate(context, HomeScreen());
                  },
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
