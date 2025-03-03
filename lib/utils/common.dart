import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/base/base._repository.dart';
import 'package:untitled/models/my_user.dart';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
void navigate(BuildContext context, Widget redirectScreen,
    {RouteTransitionsBuilder? transitionsBuilder ,VoidCallback? callback,}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => redirectScreen,
      transitionsBuilder: transitionsBuilder ??
          (context, animation, secondaryAnimation, child) {
            // Default transition (SlideTransition)
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
    ),
  ).then((_) {
    if (callback != null) {
      callback();
    }
  });
}

Future<void> selectDate({
  required BuildContext context,
  required TextEditingController controller,
}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF990011),
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    controller.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
  }
}

Widget SpacingHeight(double height) {
  return (SizedBox(height: height));
}
void showToast({
  required String message,
  ToastGravity gravity = ToastGravity.BOTTOM,
  Color backgroundColor = Colors.black,
  Color textColor = Colors.white,
  double fontSize = 16.0,
  int toastLength = 1,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: toastLength == 1 ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
    gravity: gravity,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: fontSize,
  );
}

Map<String, dynamic> castToMap(Map<Object?, Object?> map) {
  return Map<String, dynamic>.from(map);
}

Uint8List base64ToBytes(String base64String) {
  String cleanBase64 = base64String.replaceAll(RegExp(r'^data:image\/[a-zA-Z]+;base64,'), '');

  return base64Decode(cleanBase64);
}
class UserDataWidget extends StatelessWidget {
  final Future<MyUser?> userDataFuture;
  final Widget Function(MyUser? user)? builder;
  const UserDataWidget({required this.userDataFuture, this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser?>(
      future: userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          MyUser? user = snapshot.data;
          if (builder != null) {
            return builder!(user);
          } else {
            return user == null
                ? Center(child: Text('No user data found'))
                : Text('Welcome, ${user.fullName}');
          }
        } else {
          return Center(child: Text('No user data available'));
        }
      },
    );
  }
}

final BaseRepository<Map<String, dynamic>> _passwordResetRepository =
BaseRepository<Map<String, dynamic>>('password_resets');
Future<String> generateResetToken(String email) async {
  final random = Random.secure();
  final randomBytes = List<int>.generate(16, (_) => random.nextInt(256));
  final token = base64UrlEncode(randomBytes);

  final hash = sha256.convert(utf8.encode('$email$token')).toString();

  final expiryTime = DateTime.now().millisecondsSinceEpoch + (15 * 60 * 1000);

  await _passwordResetRepository.create({
    "email": email,
    "expiry": expiryTime,
  });

  return hash;
}

Future<String?> verifyResetToken(String token) async {
  final snapshot = await  _passwordResetRepository.getRef().child(token).get();

  if (!snapshot.exists) return null;

  final data = snapshot.value as Map;
  final expiry = data["expiry"] as int;
  final email = data["email"] as String;

  if (DateTime.now().millisecondsSinceEpoch > expiry) {
    await _passwordResetRepository.getRef().child(token).remove();
    return null;
  }

  return email; // Trả về email nếu hợp lệ
}

Future<String> createDynamicLink(String resetToken) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://medmatecopy2589668344.page.link',
    link: Uri.parse('https://medmatecopy2589668344.page.link/reset-password?token=$resetToken'),
    androidParameters: AndroidParameters(
      packageName: 'com.example.untitled',
      minimumVersion: 1,
    ),
    iosParameters: IOSParameters(
      bundleId: 'com.yourapp.ios',
      minimumVersion: '1.0.1',
    ),
  );

  final ShortDynamicLink shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  return shortLink.shortUrl.toString();
}


void appLog(Object obj,String? message){
  if (kDebugMode) {
    print('${message ?? obj } :: ${obj.toString()}'  );
  }
}

void openLink(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Không thể mở link: $url';
  }
}