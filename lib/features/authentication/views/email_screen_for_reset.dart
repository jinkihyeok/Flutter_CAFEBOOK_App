import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/view_models/signup_vm.dart';
import 'package:caffe_app/features/authentication/views/auth_number_screen.dart';
import 'package:caffe_app/features/authentication/views/password_screen.dart';
import 'package:caffe_app/features/authentication/views/widgets/auth_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailScreenForReset extends ConsumerStatefulWidget {
  const EmailScreenForReset({super.key});

  @override
  ConsumerState<EmailScreenForReset> createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreenForReset> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _email = '';
  bool _isSubmited = false;

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

  String getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return '해당 이메일로 등록된 사용자를 찾을 수 없습니다.';
      case 'wrong-password':
        return '비밀번호가 잘못되었습니다.';
      case 'user-disabled':
        return '이 사용자는 비활성화되었습니다.';
      case 'too-many-requests':
        return '너무 많은 시도가 감지되었습니다. 나중에 다시 시도해주세요.';
      case 'email-already-in-use':
        return '이 이메일은 이미 사용 중입니다.';
      case 'invalid-email':
        return '잘못된 이메일 형식입니다.';
      default:
        return '알 수 없는 오류가 발생했습니다.';
    }
  }

  void _onSubmitTap() async {
    try {
      await auth.sendPasswordResetEmail(email: _email);
      setState(() {
        _isSubmited = true;
      });
    } catch (e) {
      if (e is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(getFirebaseAuthErrorMessage(e.code)),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("오류가 발생했습니다."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
            child: !_isSubmited
                ? Column(
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
                          text: '확인',
                          backgroundColor:
                              _email.isEmpty || _isEmailValid() != null
                                  ? Colors.grey.shade300
                                  : Theme.of(context).primaryColor,
                          color: _email.isEmpty || _isEmailValid() != null
                              ? Colors.grey.shade400
                              : Colors.white,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gaps.v40,
                      const Text(
                        '비밀번호 재설정 이메일을\n전송했습니다.',
                        style: TextStyle(
                          fontSize: Sizes.size28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Gaps.v16,
                      Text(
                        '$_email로 전송된 이메일을 확인해주세요.',
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.black54,
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
