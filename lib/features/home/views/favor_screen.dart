import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/features/detailpage/view_models/cafe_vm.dart';
import 'package:caffe_app/features/home/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/sizes.dart';

class FavorScreen extends ConsumerWidget {
  const FavorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(usersProvider).value;
    final cafeData = ref.watch(cafesProvider).value;
    final favorites = cafeData
            ?.where((cafe) => userProfile?.favorites.contains(cafe.id) ?? false)
            .toList() ??
        [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
      ),
      body: userProfile == null || cafeData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
                vertical: Sizes.size16,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return GridTile(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Sizes.size8),
                          ),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: favorites[index].imageUri,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Gaps.v8,
                      Text(
                        favorites[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        favorites[index].location,
                        style: const TextStyle(
                          fontSize: Sizes.size14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
