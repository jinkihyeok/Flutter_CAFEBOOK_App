import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/views/second_screen.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstScreen extends StatelessWidget {
  static const routeName = 'firstScreen';
  static const routeURL = '/';
  const FirstScreen({super.key});

  void _onStartTap(BuildContext context) {
    context.pushNamed(SecondScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size20,
          vertical: Sizes.size32,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v80,
              const Text(
                'SENECA',
                style: TextStyle(
                  fontSize: Sizes.size32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Gaps.v20,
              const Text(
                '느낌있는 멘트가\n들어갈 자리',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () => _onStartTap(context),
                child: AuthButton(
                  text: "시작하기",
                  color: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
