import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/features/home/views/item_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {

  final String placeId;

  const DetailScreen({super.key, required this.placeId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = context.read<ItemViewModel>().imageUrl;
    print(imageUrl);
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
              width: double.infinity,
              height: 300,
              imageUrl: imageUrl,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text('가게명'),
        ],
      ),
    );
  }
}
