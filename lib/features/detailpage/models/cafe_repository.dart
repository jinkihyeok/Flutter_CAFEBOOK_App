import 'package:cloud_firestore/cloud_firestore.dart';

import 'cafe_model.dart';

class CafeRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Cafe>> getCafes() async {
    QuerySnapshot snapshot = await _db.collection('cafes').get();
    return snapshot.docs.map((doc) => Cafe.fromJson(doc)).toList();
  }
}
