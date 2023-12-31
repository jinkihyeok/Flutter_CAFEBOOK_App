import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/features/detailpage/view_models/cafe_vm.dart';
import 'package:caffe_app/features/home/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/sizes.dart';
import '../../detailpage/views/detailScreen.dart';

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

    void onTileTap(favorites, index) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            cafe: favorites[index],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
        backgroundColor: Colors.white,
      ),
      body: userProfile == null || cafeData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
            child: favorites.isEmpty
                ? const Center(
                    child: Text(
                      '즐겨찾기 목록이 비어있습니다.',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
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
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => onTileTap(favorites, index),
                        child: GridTile(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(Sizes.size8),
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
                        ),
                      );
                    },
                  ),
          ),
    );
  }
}
