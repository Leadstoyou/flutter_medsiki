import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/auth/reset_password_screen.dart';
import 'package:untitled/utils/local_storage.dart';
import 'base/base._repository.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/my_user.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
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
  Stripe.publishableKey = "pk_test_51QxKABQ2GPSXqnNuLcfXMLe20Vi3O2x5HNMtpIyg9y13MRXZGFFxzDBw6ZjRx0Owocy3Nt9yn6zAf7mnIuf0YWk700WGWAqvGD";
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: SplashScreen(),
    );
  }
}
