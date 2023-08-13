import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/features/home/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';
import '../models/cafe_model.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final Cafe cafe;

  const DetailScreen({super.key, required this.cafe});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _setupFavoriteStatus();
  }

  void _setupFavoriteStatus() async {
    final cafeId = widget.cafe.id;

    List<String> userFavorites = await ref.read(usersProvider.notifier).getUserFavorites();
    setState(() {
      isFavorite = userFavorites.contains(cafeId);
    });
  }

  void _toggleFavorite() async {
    final cafeId = widget.cafe.id;

    if (!isFavorite) {
      await ref.read(usersProvider.notifier).addFavorite(cafeId);
    } else {
      await ref.read(usersProvider.notifier).deleteFavorite(cafeId);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
            ),
            child: IconButton(
              onPressed: _toggleFavorite,
              icon: FaIcon(
                isFavorite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                size: Sizes.size24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
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
        ],
      ),
    );
  }
}
