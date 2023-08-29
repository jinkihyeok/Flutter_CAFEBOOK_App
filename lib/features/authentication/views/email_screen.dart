import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/view_models/signup_vm.dart';
import 'package:caffe_app/features/authentication/views/auth_number_screen.dart';
import 'package:caffe_app/features/authentication/views/password_screen.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  ConsumerState<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
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

  void _onSubmitTap() async {
    if (_email.isEmpty || _isEmailValid() != null) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "email": _email};

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PasswordScreen(email: _email),
      ),
    );
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
                Gaps.v40,
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
