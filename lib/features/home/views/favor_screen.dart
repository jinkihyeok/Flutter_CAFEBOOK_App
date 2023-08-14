import 'package:caffe_app/features/detailpage/view_models/cafe_vm.dart';
import 'package:caffe_app/features/home/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(favorites[index].name),
                );
              }),
    );
  }
}
