import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/view_models/user_vm.dart';
import '../../home/views/home_screen.dart';
import '../repos/authentication_repo.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> googleLogin(BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
       final credential = await _repository.signInWithGoogle();
        if (!state.hasError) {
        await ref.read(usersProvider.notifier).createProfile(credential);
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
        builder: (context) => const HomeScreen(),
        ),
        (route) => false);
        }
      }
    );
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
  () => SocialAuthViewModel(),
);
