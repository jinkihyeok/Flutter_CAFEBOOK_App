import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/view_models/social_auth_vm.dart';
import 'package:caffe_app/features/authentication/views/login_form_screen.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondScreen extends ConsumerWidget {
  const SecondScreen({super.key});

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
          vertical: Sizes.size60,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '시작하기',
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => ref.read(socialAuthProvider.notifier).googleLogin(context),
                child: AuthButton(
                  text: '구글로 로그인',
                  color: Colors.black,
                  backgroundColor: Colors.white,
                  icon: Image.asset('assets/icons/google.png'),
                ),
              ),
              Gaps.v28,
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.white.withOpacity(0.7),
              ),
              Gaps.v28,
              GestureDetector(
                onTap: () => _onEmailTap(context),
                child: const AuthButton(
                  text: '이메일 로그인',
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
