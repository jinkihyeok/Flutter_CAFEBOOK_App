import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/views/email_verification_screen.dart';
import 'package:caffe_app/features/authentication/views/username_screen.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../view_models/signup_vm.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  final String email;

  const PasswordScreen({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordLengthValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  bool _isPasswordValid() {
    final passwordPattern = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    return passwordPattern.hasMatch(_password);
  }

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() async {
    if (!_isPasswordLengthValid() || !_isPasswordValid()) return;

    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};

    await ref.read(signUpProvider.notifier).emailSignUp();

    setState(() {
      _isLoading = true;
    });

   await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmailVerificationScreen(),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScafoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v40,
                const Text(
                  '비밀번호를\n설정해주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v10,
                Text(
                  widget.email,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black54,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: _onClearTap,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h16,
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    hintText: '비밀번호',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Gaps.v14,
                Row(
                  children: [
                    FaIcon(
                      _isPasswordLengthValid()
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.check,
                      size: Sizes.size16,
                      color: _isPasswordLengthValid()
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    Gaps.h6,
                    Text(
                      '8자리 이상',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: _isPasswordLengthValid()
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                Gaps.v14,
                Row(
                  children: [
                    FaIcon(
                      _isPasswordValid()
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.check,
                      size: Sizes.size16,
                      color: _isPasswordValid()
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    Gaps.h6,
                    Text(
                      '영문, 숫자, 특수문자 포함',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: _isPasswordValid()
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: !_isLoading ? AuthButton(
                    text: '다음',
                    backgroundColor:
                        !_isPasswordLengthValid() || !_isPasswordValid()
                            ? Colors.grey.shade300
                            : Theme.of(context).primaryColor,
                    color: !_isPasswordLengthValid() || !_isPasswordValid()
                        ? Colors.grey.shade400
                        : Colors.white,
                  ) : const Center(
                    child: CircularProgressIndicator(color: Colors.black,),
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
