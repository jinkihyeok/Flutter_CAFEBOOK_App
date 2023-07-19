import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detailScreen';
  static const routeURL = ':placeId';

  final String placeId;
  const DetailScreen({super.key, required this.placeId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.placeId),
      ),
    );
  }
}
