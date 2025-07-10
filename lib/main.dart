import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/route/route_config.dart';
import 'package:untitled/screens/auth/reset_password_screen.dart';
import 'package:untitled/screens/payment/payment_screen.dart';
import 'package:untitled/screens/payment/result_screen.dart';
import 'package:untitled/utils/local_storage.dart';
import 'base/base._repository.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCMPdYmwzDgE0UZde6HV9rC3zB1r-rr1Lc",
        authDomain: "support-medsiki.firebaseapp.com",
        projectId: "support-medsiki",
        storageBucket: "support-medsiki.firebasestorage.app",
        messagingSenderId: "400684593618",
        appId: "1:400684593618:web:93b3b386b2efb85d81180b",
        measurementId: "G-SH4YYXH5FS",
      ),
    );
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }
  await dotenv.load(fileName: ".env");
  print('Ứng dụng đã bắt đầu');
  print(dotenv.env['ORDER_URL']);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _appLinks = AppLinks(); // Singleton AppLinks
  Uri? _initialUri;

  @override
  void initState() {
    super.initState();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() {
    // Lắng nghe tất cả các sự kiện deep link (bao gồm initial link và stream)
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null && mounted) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      log('Error listening to deep link: $err');
    });

    // Kiểm tra initial link khi ứng dụng khởi động
    _appLinks.getInitialLink().then((Uri? uri) {
      if (uri != null) {
        _initialUri = uri;
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('Deep link received: ${uri.toString()}');
      final path = uri.path;
      final queryParams = uri.queryParameters;

      if (path == '/' || path == '/result' || uri.toString().contains('payosdemoflutter/result')) {
        final status = queryParams['status'] ?? 'unknown';
        log('Navigating to result screen with status: $status');
        Future.microtask(() {
          appRouter.go(RoutePaths.onboardingFirstScreen);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      builder: (context, child) {
        if (_initialUri != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _handleDeepLink(_initialUri!);
              _initialUri = null;
            }
          });
        }
        return child!;
      },
    );
  }
}
