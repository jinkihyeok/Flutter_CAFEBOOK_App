import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavorScreen extends StatefulWidget {
  const FavorScreen({Key? key}) : super(key: key);

  @override
  FavorScreenState createState() => FavorScreenState();
}

class FavorScreenState extends State<FavorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
      ),
      body: const Center(
        child: Text('Favor'),
      ),);
  }
}
