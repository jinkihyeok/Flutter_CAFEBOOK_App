import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/authentication/widgets/agree_listTile.dart';
import 'package:caffe_app/features/authentication/widgets/auth_button.dart';
import 'package:caffe_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgreeScreen extends StatefulWidget {
  const AgreeScreen({super.key});

  @override
  State<AgreeScreen> createState() => _AgreeScreenState();
}

class _AgreeScreenState extends State<AgreeScreen> {
  List agrees = [
    {
      'title': '만 14세 이상입니다. *',
      'isAgree': false,
    },
    {
      'title': '이용 약관에 동의합니다. *',
      'isAgree': false,
    },
    {
      'title': '개인정보 수집 및 이용에 동의합니다. *',
      'isAgree': false,
    },
    {
      'title': '개인정보 수집 및 이용에 동의합니다.(선택)',
      'isAgree': false,
    },
    {
      'title': '마케팅 정보 수신에 동의합니다.(선택)',
      'isAgree': false,
    },
  ];

  bool _isAllAgree() {
    for (final agree in agrees) {
      if (!agree['isAgree']) {
        return false;
      }
    }
    return true;
  }

  bool _isEssentialAgree() {
    for (final agree in agrees) {
      if (agree['title'].contains('*') && !agree['isAgree']) {
        return false;
      }
    }
    return true;
  }

  void _onAllAgreeTap() {
    if (_isAllAgree()) {
      setState(
        () {
          for (final agree in agrees) {
            agree['isAgree'] = false;
          }
        },
      );
      return;
    }
    setState(
      () {
        for (final agree in agrees) {
          agree['isAgree'] = true;
        }
      },
    );
  }

  void _onNextTap(BuildContext context) {
    if (!_isEssentialAgree()) {
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
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size14),
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
                child: ListView(
                  children: [
                    ListTile(
                      onTap: _onAllAgreeTap,
                      leading: FaIcon(
                        _isAllAgree()
                            ? FontAwesomeIcons.solidCircleCheck
                            : FontAwesomeIcons.circleCheck,
                        color: _isAllAgree() ? Colors.black : Colors.grey,
                      ),
                      title: const Text(
                        '전체 동의',
                        style: TextStyle(
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    for (final agree in agrees)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            agree['isAgree'] = !agree['isAgree'];
                          });
                        },
                        child: AgreeListTile(
                          title: agree['title'],
                          isAgree: agree['isAgree'],
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
                  backgroundColor: _isEssentialAgree()
                      ? Theme.of(context).primaryColor
                      : Colors.grey.shade300,
                  color:
                      _isEssentialAgree() ? Colors.white : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
