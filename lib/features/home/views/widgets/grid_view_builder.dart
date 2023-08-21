import 'package:caffe_app/features/home/views/widgets/signature_description.dart';
import 'package:caffe_app/features/home/views/widgets/signature_image.dart';
import 'package:flutter/material.dart';
import '../../../../constants/sizes.dart';
import '../../../detailpage/models/cafe_model.dart';

Widget buildGridView(
  List<Cafe> cafes,
  Future<void> Function() onRefresh,
  void Function(Cafe cafe) onDetailTap,
) {
  return RefreshIndicator(
    color: Colors.black,
    onRefresh: onRefresh,
    child: GridView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
        vertical: Sizes.size16,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: Sizes.size10,
        childAspectRatio: 1,
      ),
      itemCount: cafes.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => onDetailTap(cafes[index]),
        child: Column(
          children: [
            SignatureImage(
              imageUri: cafes[index].imageUri,
              id: cafes[index].id,
            ),
            SignatureDescription(
              cafe: cafes[index],
            ),
          ],
        ),
      ),
    ),
  );
}
