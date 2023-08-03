import 'dart:async';
import 'package:caffe_app/features/authentication/repos/authentication_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/views/home_screen.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> logIn(
      String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepo.signIn(email, password),
    );
    if (state.hasError) {
      final snack = SnackBar(
        showCloseIcon: true,
        content: Text(
          (state.error as FirebaseException).message ?? "로그인에 실패하였습니다.",
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }
  }
}

final loginProvider =
    AsyncNotifierProvider<LoginViewModel, void>(() => LoginViewModel());
