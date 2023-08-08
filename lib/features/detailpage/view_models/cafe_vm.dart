import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cafe_model.dart';
import '../models/cafe_repository.dart';

final cafeRepositoryProvider = Provider<CafeRepository>((ref) => CafeRepository());

final cafesProvider = FutureProvider<List<Cafe>>((ref) async {
  final repo = ref.read(cafeRepositoryProvider);
  return await repo.getCafes();
});
