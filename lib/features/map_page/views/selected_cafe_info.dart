import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/features/detailpage/models/cafe_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';

class SelectedCafeInfo extends StatelessWidget {
  final Cafe? selectedCafe;
  final bool isFavorite;
  final VoidCallback onTap;

  const SelectedCafeInfo({
    Key? key,
    required this.selectedCafe,
    required this.isFavorite,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Sizes.size80,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 1,
                  blurRadius: Sizes.size8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            height: 110,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    height: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: selectedCafe!.imageUri,
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.size14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedCafe!.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600),
                            ),
                            FaIcon(
                              isFavorite
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              size: Sizes.size16,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Gaps.v20,
                        Text(selectedCafe!.location),
                        Text(
                            '${selectedCafe!.openingTime} ~ ${selectedCafe!.closingTime}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
