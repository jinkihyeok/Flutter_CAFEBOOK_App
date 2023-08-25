import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../view_models/user_vm.dart';

class SignatureImage extends ConsumerWidget {
  final List<String> imageUri;
  final String id;

  const SignatureImage({
    required this.imageUri,
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(usersProvider).value;
    final isFavorite = userProfile?.favorites.contains(id) ?? false;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size8),
      ),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: PageView.builder(
              itemCount: imageUri.length,
              itemBuilder: (context, index) {
                return FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: "assets/images/morning_coffee.jpeg",
                  image: imageUri[index],
                );
              },
            ),
          ),
           Positioned(
            top: 16,
            right: 16,
            child: FaIcon(
             isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              size: Sizes.size24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
