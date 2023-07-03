import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureDescription extends StatelessWidget {
  const SignatureDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '모멘도르',
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.solidStar,
                  size: Sizes.size12,
                ),
                Gaps.h3,
                Text(
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
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '지정면',
                ),
                Text(
                  '15km 거리',
                ),
                Text(
                  '10:00 ~ 21:00 (매주 화 휴무)',
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
