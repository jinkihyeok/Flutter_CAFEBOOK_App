import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/view_models/agree_vm.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:caffe_app/features/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgreeScreen extends StatelessWidget {
  final AgreeViewModel viewModel;
  const AgreeScreen({super.key, required this.viewModel});

  void _onNextTap(BuildContext context) {
    if (!viewModel.isEssentialAgree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '필수 항목에 동의해주세요.',
            textAlign: TextAlign.center,
          ),
        ),
      );
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size14,
            vertical: Sizes.size20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v80,
              const Text(
                '시작하시기 전,\n아래 내용을 확인해주세요.',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v10,
              const Text(
                '* 표시는 필수 항목입니다.',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black54,
                ),
              ),
              Gaps.v24,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => viewModel.toggleAllAgree(),
                      child: const Text('전체 동의',
                          style: TextStyle(
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          )),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: viewModel.agrees.length,
                        itemBuilder: (context, index) {
                          final agree = viewModel.agrees[index];
                          return ListTile(
                            onTap: () => viewModel.toggleAgree(index),
                            title: Text(agree.title),
                            leading: FaIcon(
                              agree.isAgree
                                  ? FontAwesomeIcons.solidCircleCheck
                                  : FontAwesomeIcons.circleCheck,
                              color: agree.isAgree ? Colors.black : Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v28,
              GestureDetector(
                onTap: () => _onNextTap(context),
                child: AuthButton(
                  text: '다음',
                  backgroundColor: viewModel.isEssentialAgree
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                  color: viewModel.isEssentialAgree
                      ? Colors.white
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
