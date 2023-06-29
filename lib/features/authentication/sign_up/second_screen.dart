import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/sign_up/login_form_screen.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginFormScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size28,
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
              AuthButton(
                text: '카카오로 계속하기',
                color: Colors.black,
                backgroundColor: const Color(0xFFFFCD00),
                icon: Image.asset('assets/icons/kakao.png'),
              ),
              Gaps.v12,
              AuthButton(
                text: '네이버로 계속하기',
                color: Colors.black,
                backgroundColor: const Color(0xFF03C75A),
                icon: Image.asset('assets/icons/naver.png'),
              ),
              Gaps.v12,
              AuthButton(
                text: '구글로 계속하기',
                color: Colors.black,
                backgroundColor: Colors.white,
                icon: Image.asset('assets/icons/google.png'),
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
                  text: '이메일로 계속하기',
                  color: Colors.white,
                  backgroundColor: Color(0xFF051010),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
