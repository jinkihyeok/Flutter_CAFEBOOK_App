import 'package:caffe_app/features/authentication/sign_up/login_form_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CaffeApp());
}

class CaffeApp extends StatelessWidget {
  const CaffeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caffe App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        useMaterial3: true,
      ),
      home: const LoginFormScreen(),
    );
  }
}
