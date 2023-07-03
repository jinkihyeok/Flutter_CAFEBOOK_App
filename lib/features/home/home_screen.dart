import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/home/search_screen.dart';
import 'package:caffe_app/features/home/setting_bar_screen.dart';
import 'package:caffe_app/features/home/widgets/signature_description.dart';
import 'package:caffe_app/features/home/widgets/signature_image.dart';
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
  int _itemCount = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _itemCount += 10;
      });
    }
  }

  void _onTabBarTap(int index) {
    FocusScope.of(context).unfocus();
  }

  void _onSearchBarTap(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );
  }

  void _onSettingBarTap(BuildContext context) async {
    await showDialog(
      useSafeArea: false,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) => const SettingBarScreen(),
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
                GestureDetector(
                  onTap: () => _onSettingBarTap(context),
                  child: const SizedBox(
                    child: FaIcon(
                      FontAwesomeIcons.bars,
                    ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size16,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: Sizes.size10,
                childAspectRatio: 1,
              ),
              findChildIndexCallback: (key) => null,
              itemCount: _itemCount,
              controller: _scrollController,
              itemBuilder: (context, index) => const Column(
                children: [
                  SignatureImage(),
                  SignatureDescription(),
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
