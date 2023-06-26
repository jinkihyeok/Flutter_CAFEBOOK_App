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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Container(),
    );
  }
}
