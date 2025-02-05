import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:swap_store/constants/constants.dart';
import 'package:swap_store/firebase_options.dart';
import 'package:swap_store/services/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "swap shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: buttonColor,
          scaffoldBackgroundColor: Color(0xffF1F4F8)),
      home: AuthGate(),
    );
  }
}
