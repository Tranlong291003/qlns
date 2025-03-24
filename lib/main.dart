import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:qlns/screens/login/login_page.dart';
import 'package:qlns/screens/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RootScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
