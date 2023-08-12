import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureImage extends StatelessWidget {
  final String imageUri;

  const SignatureImage({
    required this.imageUri,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  image: imageUri,
                );
              },
            ),
          ),
          const Positioned(
            top: 16,
            right: 16,
            child: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: Sizes.size24,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
