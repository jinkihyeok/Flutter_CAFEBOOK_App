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
    try {
      await _db.collection('users').doc(uid).update(
        {
          'favorites': FieldValue.arrayUnion([cafeId]),
        },
      );
    } catch (error) {
      print('Error updating favorites: $error');
    }
  }


  Future<void> deleteFavorite(String uid, String cafeId) async {
    await _db.collection('users').doc(uid).update(
      {
        'favorites': FieldValue.arrayRemove([cafeId]),
      },
    );
    print('userRepo!');
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
