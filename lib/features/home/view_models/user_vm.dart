import 'dart:async';

import 'package:caffe_app/features/home/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/view_models/signup_vm.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    final emailUserName = ref.read(signUpForm)['name'];

    state = AsyncValue.data(
      UserProfileModel(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: credential.user!.displayName ?? emailUserName,
      ),
    );
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
