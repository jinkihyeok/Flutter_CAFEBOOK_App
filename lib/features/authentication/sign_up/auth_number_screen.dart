import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/sign_up/password_screen.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class AuthNumberScreen extends StatefulWidget {
  final String email;
  const AuthNumberScreen({super.key, required this.email});

  @override
  State<AuthNumberScreen> createState() => _AuthNumberScreenState();
}

class _AuthNumberScreenState extends State<AuthNumberScreen> {
  final TextEditingController _authNumberController = TextEditingController();

  String _authnumber = '';

  @override
  void initState() {
    super.initState();
    _authNumberController.addListener(() {
      setState(() {
        _authnumber = _authNumberController.text;
      });
    });
  }

  @override
  void dispose() {
    _authNumberController.dispose();
    super.dispose();
  }

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onNextTap() {
    if (_authnumber.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
  }

  String? _isAuthNumberValid() {
    if (_authnumber.isEmpty) return null;
    if (_authnumber.length != 4) {
      return "인증번호는 4자리입니다.";
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
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v40,
                const Text(
                  '이메일 인증',
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v10,
                Text(
                  '${widget.email} 이메일 주소로 발송된\n4자리 숫자를 입력해주세요.',
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.black54,
                  ),
                ),
                Gaps.v16,
                TextField(
                  controller: _authNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: '인증번호',
                    errorText: _isAuthNumberValid(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: _onNextTap,
                  child: AuthButton(
                    text: '다음',
                    backgroundColor:
                        _authnumber.isEmpty || _isAuthNumberValid() != null
                            ? Colors.grey.shade300
                            : Theme.of(context).primaryColor,
                    color: _authnumber.isEmpty || _isAuthNumberValid() != null
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
