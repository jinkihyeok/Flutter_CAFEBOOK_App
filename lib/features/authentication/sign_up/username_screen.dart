import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:flutter/material.dart';

class UserNameScreen extends StatefulWidget {
  const UserNameScreen({super.key});

  @override
  State<UserNameScreen> createState() => _UserNameScreenState();
}

class _UserNameScreenState extends State<UserNameScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                    hintText: '이름 또는 닉네임',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    )),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v28,
              AuthButton(
                text: '시작하기',
                backgroundColor: _username.isEmpty
                    ? Colors.grey.shade300
                    : Theme.of(context).primaryColor,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
