import 'dart:async';

import 'package:caffe_app/features/authentication/repos/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home/view_models/user_vm.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> emailSignUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);
    final users = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(
      () async {
       final userCredential = await _authRepo.signUpWithEmail(
          form['email'],
          form['password'],
        );
         await users.createAccount(userCredential);
       },
    );
  }
}

final signUpForm = StateProvider(
  (ref) => <String, dynamic>{},
);

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
