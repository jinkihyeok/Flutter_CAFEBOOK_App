import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/sign_up/auth_number_screen.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = '';

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return "이메일 형식이 올바르지 않습니다.";
    }
    return null;
  }

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmitTap() {
    if (_email.isEmpty || _isEmailValid() != null) return;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AuthNumberScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScafoldTap,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v80,
                const Text(
                  '이메일 주소를\n입력해주세요.',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    hintText: 'email@address.com',
                    errorText: _isEmailValid(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: AuthButton(
                    text: '다음',
                    backgroundColor: _email.isEmpty || _isEmailValid() != null
                        ? Colors.grey.shade300
                        : Theme.of(context).primaryColor,
                    color: _email.isEmpty || _isEmailValid() != null
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
