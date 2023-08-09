import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:flutter/material.dart';

import '../models/cafe_model.dart';

class DetailScreen extends StatefulWidget {
  final Cafe cafe;
  const DetailScreen({super.key, required this.cafe});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.cafe.imageUri,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Gaps.v20,
          Text(widget.cafe.name),
          Text(widget.cafe.address),
          Text('${widget.cafe.openingTime} ~ ${widget.cafe.closingTime}'),
          Text('${widget.cafe.lat}, ${widget.cafe.lng}'),
        ],
      ),
    );
  }
}
