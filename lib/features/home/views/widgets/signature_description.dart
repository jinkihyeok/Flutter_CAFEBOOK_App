import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignatureDescription extends StatelessWidget {
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String openingTime;
  final String closingTime;

  const SignatureDescription({
    super.key, required this.name, required this.address, required this.openingTime, required this.closingTime, required this.lat, required this.lng,
  });

  String extractRegion(String address) {
    final List<String> keywords = ["읍", "면", "동"];
    for (var keyword in keywords) {
      final pattern = RegExp(r"(\S+" + keyword + ")");
      final match = pattern.firstMatch(address);
      if (match != null) {
        return match.group(1)!;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
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
                    name,
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
                  extractRegion(address),
                ),
                Text(
                  '$lat, $lng'
                ),
                 Text(
                  '$openingTime ~ $closingTime',
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
