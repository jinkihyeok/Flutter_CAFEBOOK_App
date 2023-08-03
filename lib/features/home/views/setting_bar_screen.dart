import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../authentication/repos/authentication_repo.dart';

class SettingBarScreen extends ConsumerWidget {
  final Function close;

  const SettingBarScreen({super.key, required this.close});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.7,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
            vertical: Sizes.size20,
          ),
          child: SafeArea(
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: close as void Function(),
                    child: const FaIcon(
                      FontAwesomeIcons.circleXmark,
                    ),
                  ),
                  Gaps.v80,
                  const Text(
                    '닉네임',
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v10,
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          'assets/icons/kakao.png',
                        ),
                      ),
                      Gaps.h10,
                      const Expanded(
                        child: Text(
                          'email@address.com',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gaps.v20,
                  Container(
                    width: double.infinity,
                    height: 1.5,
                    color: Colors.grey[400],
                  ),
                  Gaps.v20,
                  DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size18,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size20,
                            ),
                            Gaps.h14,
                            Text('위시리스트'),
                          ],
                        ),
                        Gaps.v20,
                        GestureDetector(
                          onTap: () => showAboutDialog(
                              context: context,
                              applicationVersion: "1.0.0",
                              applicationIcon: const FlutterLogo(),
                              applicationLegalese: "© 2023 Caffe App",
                              children: const [
                                Text("Caffe App은 Flutter를 이용하여 제작된 앱입니다."),
                              ]),
                          child: const Row(
                            children: [
                              FlutterLogo(
                                size: Sizes.size20,
                              ),
                              Gaps.h14,
                              Text('About'),
                            ],
                          ),
                        ),
                        Gaps.v20,
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text('로그아웃'),
                                content: const Text('로그아웃 하시겠습니까?'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text('취소'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    child: const Text('확인'),
                                    onPressed: () => ref.read(authRepo).signOut(),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.arrowRotateLeft,
                                size: Sizes.size20,
                              ),
                              Gaps.h14,
                              Text('로그아웃'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
