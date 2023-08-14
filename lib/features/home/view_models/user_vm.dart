import 'dart:async';

import 'package:caffe_app/features/authentication/repos/authentication_repo.dart';
import 'package:caffe_app/features/home/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/view_models/signup_vm.dart';
import '../repo/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _userRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);

    if (_authenticationRepository.isLoggedIn) {
      final profile =
          await _userRepository.getProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
    }

  Future<void> createProfile(UserCredential credential) async {
    final emailUserName = ref.read(signUpForm)['username'];
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email!,
      name: credential.user!.displayName ?? emailUserName,
      favorites: [],
    );
    await _userRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> addFavorite(String cafeId) async {
    final uid = _authenticationRepository.user!.uid;
    await _userRepository.setFavorite(uid, cafeId);

    List<String> updatedFavorites = await _userRepository.getUserFavorites(uid);

    if (state is AsyncData<UserProfileModel>) {
      final currentProfile = (state as AsyncData<UserProfileModel>).value;
      final updatedProfile = UserProfileModel(
        uid: currentProfile.uid,
        email: currentProfile.email,
        name: currentProfile.name,
        favorites: updatedFavorites,
      );
      state = AsyncValue.data(updatedProfile);
    }
  }

  Future<void> deleteFavorite(String cafeId) async {
    final uid = _authenticationRepository.user!.uid;
    await _userRepository.deleteFavorite(uid, cafeId);

    List<String> updatedFavorites = await _userRepository.getUserFavorites(uid);

    if (state is AsyncData<UserProfileModel>) {
      final currentProfile = (state as AsyncData<UserProfileModel>).value;
      final updatedProfile = UserProfileModel(
        uid: currentProfile.uid,
        email: currentProfile.email,
        name: currentProfile.name,
        favorites: updatedFavorites,
      );
      state = AsyncValue.data(updatedProfile);
    }
  }

  Future<List<String>> getUserFavorites() async {
    final uid = _authenticationRepository.user!.uid;
   List<String> favorites = await _userRepository.getUserFavorites(uid);
   return favorites ?? [];
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
