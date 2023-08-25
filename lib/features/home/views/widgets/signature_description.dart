import 'package:caffe_app/features/detailpage/models/cafe_model.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/util/distances_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureDescription extends ConsumerWidget {
  final Cafe cafe;

  const SignatureDescription({
    super.key,
    required this.cafe,
  });

  String get closedDay {
    if (cafe.closedDay == '') {
      return '매일';
    } else {
      return cafe.closedDay;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    cafe.name,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.solidStar,
                  size: Sizes.size12,
                ),
                Gaps.h3,
                 Text(
                   (cafe.likes).toStringAsFixed(1),
                ),
              ],
            ),
          ),
          Gaps.v8,
          DefaultTextStyle(
            style: TextStyle(
              fontSize: Sizes.size14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade500,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cafe.location,
                ),
                DistanceWidget(cafe: cafe),
                Text(
                  '${cafe.openingTime} ~ ${cafe.closingTime}  $closedDay',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
