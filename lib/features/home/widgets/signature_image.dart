import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureImage extends StatelessWidget {
  const SignatureImage({
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
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: "assets/images/background_image.jpg",
              image:
                  "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230318_39%2F1679104703292HUfgW_JPEG%2FKakaoTalk_20230317_132200432_20.jpg",
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: FaIcon(
              FontAwesomeIcons.solidHeart,
              size: Sizes.size24,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
