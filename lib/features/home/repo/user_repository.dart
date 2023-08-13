import 'package:caffe_app/features/home/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> getProfile(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data();
  }

  Future<void> setFavorite(String uid, String cafeId) async {
      await _db.collection('users').doc(uid).update(
        {
          'favorites': FieldValue.arrayUnion([cafeId]),
        },
      );
  }

  Future<void> deleteFavorite(String uid, String cafeId) async {
    await _db.collection('users').doc(uid).update(
      {
        'favorites': FieldValue.arrayRemove([cafeId]),
      },
    );
  }

  Future<List<String>> getUserFavorites(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    Map<String, dynamic>? data = doc.data();
    return data?['favorites']?.cast<String>() ?? [];
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
