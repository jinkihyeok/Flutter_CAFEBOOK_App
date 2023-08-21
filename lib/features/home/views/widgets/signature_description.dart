import 'package:caffe_app/features/detailpage/models/cafe_model.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/util/calculate_distances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureDescription extends ConsumerWidget {
  final Cafe cafe;

  const SignatureDescription({
    super.key,
    required this.cafe,
  });

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
                const Text(
                  '4.5',
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
                FutureBuilder<int?>(
                  future: calculateDistances(ref, cafe),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        width: Sizes.size12,
                        height: Sizes.size12,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Text('${snapshot.data} km');
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Text(
                  '${cafe.openingTime} ~ ${cafe.closingTime}',
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
