import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/signup_vm.dart';

class UserNameScreen extends ConsumerStatefulWidget {
  const UserNameScreen({super.key});

  @override
  ConsumerState<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends ConsumerState<UserNameScreen> {
  final TextEditingController _userNameController = TextEditingController();

  String _username = '';

  @override
  void initState() {
    super.initState();
    _userNameController.addListener(() {
      setState(() {
        _username = _userNameController.text;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_username.isEmpty) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "username": _username};
    ref.read(signUpProvider.notifier).emailSignUp(context);
  }

  bool _isKoreanInput() {
    final koreanRegExp = RegExp(r'[ㄱ-ㅎ가-힣]');
    return koreanRegExp.hasMatch(_username);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScafoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v80,
                const Text(
                  '반가워요.\n이름을 알려주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v10,
                const Text(
                  '당신을 표현하는 별명이나 애칭도 좋아요.',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black54,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _userNameController,
                  maxLength: _isKoreanInput() ? 8 : 20,
                  decoration: InputDecoration(
                      hintText: '이름 또는 닉네임',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onNextTap,
                  child: AuthButton(
                    text: '시작하기',
                    backgroundColor: _username.isEmpty || ref.watch(signUpProvider).isLoading
                        ? Colors.grey.shade300
                        : Theme.of(context).primaryColor,
                    color:
                        _username.isEmpty || ref.watch(signUpProvider).isLoading ? Colors.grey.shade400 : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
