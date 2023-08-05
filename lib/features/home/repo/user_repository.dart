import 'package:caffe_app/features/home/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProfile(UserProfileModel profile) async {
   await _db.collection('users').doc(profile.uid).set(profile.toJson());
   print('User profile saved');
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
