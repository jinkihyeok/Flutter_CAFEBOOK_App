import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/sign_up/email_screen.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:caffe_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        context.goNamed(HomeScreen.routeName);
      }
    }
  }

  void _onSignUpTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const EmailScreen(),
    ));
  }

  _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일 주소를 입력해주세요.';
    }
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(value)) {
      return "이메일 형식이 올바르지 않습니다.";
    }
    return null;
  }

  _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    }
    final passwordPattern = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    if (!passwordPattern.hasMatch(value)) {
      return "비밀번호는 8자리 이상, 영문, 숫자, 특수문자를 포함해야 합니다.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScafoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  '이메일 주소를\n입력해주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v16,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'email@address.com',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) => _emailValidator(value),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['email'] = newValue;
                          }
                        },
                      ),
                      Gaps.v16,
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '비밀번호',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        validator: (value) => _passwordValidator(value),
                        onSaved: (newValue) {
                          if (newValue != null) {
                            formData['password'] = newValue;
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Gaps.v14,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('비밀번호를 잊으셨나요?'),
                    Gaps.h5,
                    Text(
                      '찾기',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onNextTap,
                  child: AuthButton(
                    text: '시작하기',
                    color: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
                Gaps.v14,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('아직 회원이 아니시라면?'),
                    Gaps.h5,
                    GestureDetector(
                      onTap: _onSignUpTap,
                      child: const Text(
                        '가입하기',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
