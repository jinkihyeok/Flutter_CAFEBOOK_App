import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/sizes.dart';
import '../features/detailpage/models/cafe_model.dart';
import 'calculate_distances.dart';

class DistanceWidget extends ConsumerWidget {
  final Cafe cafe;

  const DistanceWidget({Key? key, required this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int?>(
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
    );
  }
}
