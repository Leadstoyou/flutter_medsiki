import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils/local_storage.dart';
import 'base/base._repository.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/my_user.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCMPdYmwzDgE0UZde6HV9rC3zB1r-rr1Lc",
          authDomain: "support-medsiki.firebaseapp.com",
          projectId: "support-medsiki",
          storageBucket: "support-medsiki.firebasestorage.app",
          messagingSenderId: "400684593618",
          appId: "1:400684593618:web:93b3b386b2efb85d81180b",
          measurementId: "G-SH4YYXH5FS"),
    );
  } else {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }
  print(await getUserFromLocalStorage().toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red, textTheme: TextTheme()),
      home: SplashScreen(),
    );
  }
}
