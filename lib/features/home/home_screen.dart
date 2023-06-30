import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/home/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final tabs = [
  "인기순",
  "신규순",
  "가까운순",
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onTabBarTap(int index) {
    FocusScope.of(context).unfocus();
  }

  void _onSearchBarTap(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onSearchBarTap(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size14,
                        vertical: Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(Sizes.size20),
                      ),
                      child: const Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: Sizes.size16,
                          ),
                          Gaps.h5,
                          Text(
                            '검색',
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gaps.h16,
                const SizedBox(
                  child: FaIcon(
                    FontAwesomeIcons.bars,
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            onTap: _onTabBarTap,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            labelStyle: const TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w600,
            ),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
            indicatorWeight: 1.2,
            indicatorSize: TabBarIndicatorSize.tab,
            splashFactory: NoSplash.splashFactory,
            tabs: [
              for (final tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size16,
              ),
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size8),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.5,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: "assets/images/background_image.jpg",
                        image:
                            "https://search.pstatic.net/common/?src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20230318_39%2F1679104703292HUfgW_JPEG%2FKakaoTalk_20230317_132200432_20.jpg",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(Sizes.size16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '모멘도르',
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidStar,
                                size: Sizes.size12,
                              ),
                              Gaps.h3,
                              Text(
                                '4.5',
                              ),
                            ],
                          ),
                        ),
                        Gaps.v8,
                        DefaultTextStyle(
                          style: TextStyle(
                            fontSize: Sizes.size14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '지정면',
                              ),
                              Text(
                                '15km 거리',
                              ),
                              Text(
                                '10:00 ~ 21:00 (매주 화 휴무)',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Tab(text: tabs[1]),
            Tab(text: tabs[2]),
          ],
        ),
      ),
    );
  }
}
