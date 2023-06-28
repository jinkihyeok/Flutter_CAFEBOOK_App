import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/sign_up/auth_number_screen.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';
  bool _obscureText = true;

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

  void _onSubmitTap() {
    if (!_isPasswordLengthValid() || !_isPasswordValid()) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AuthNumberScreen(),
      ),
    );
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v80,
                const Text(
                  '비밀번호를\n설정해주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _passwordController,
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
                  cursorColor: Theme.of(context).primaryColor,
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
                          ? Colors.blue
                          : Colors.grey.shade400,
                    ),
                    Gaps.h6,
                    Text(
                      '8자리 이상',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: _isPasswordLengthValid()
                            ? Colors.blue
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
                          ? Colors.blue
                          : Colors.grey.shade400,
                    ),
                    Gaps.h6,
                    Text(
                      '영문, 숫자, 특수문자 포함',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: _isPasswordValid()
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: AuthButton(
                    text: '다음',
                    backgroundColor:
                        !_isPasswordLengthValid() || !_isPasswordValid()
                            ? Colors.grey.shade300
                            : Theme.of(context).primaryColor,
                    color: !_isPasswordLengthValid() || !_isPasswordValid()
                        ? Colors.grey.shade400
                        : Colors.white,
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
