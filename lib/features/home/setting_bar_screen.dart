import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingBarScreen extends StatelessWidget {
  final Function close;

  const SettingBarScreen({super.key, required this.close});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
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
                const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                  child: Column(
                    children: [
                      Row(
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
                      Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.gear,
                            size: Sizes.size20,
                          ),
                          Gaps.h14,
                          Text('설정'),
                        ],
                      ),
                    ],
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
