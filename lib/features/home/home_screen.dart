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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _itemCount = 10;
  final ScrollController _scrollController = ScrollController();

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<Offset> _settingBarAnimation = Tween(
    begin: const Offset(1, 0),
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationController);

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

  void _onSettingBarTap() {
    _animationController.forward();

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  void _onSettingBarClose() async {
    await _animationController.reverse();

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Stack(
        children: [
          Scaffold(
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
                      onTap: _onSettingBarTap,
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
                RefreshIndicator(
                  color: Colors.black,
                  onRefresh: _onRefresh,
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                      vertical: Sizes.size16,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
                Tab(text: tabs[1]),
                Tab(text: tabs[2]),
              ],
            ),
          ),
          Positioned(
            bottom: Sizes.size44,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size20,
                    vertical: Sizes.size10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.map,
                        color: Colors.white,
                        size: Sizes.size14,
                      ),
                      Gaps.h8,
                      Text(
                        '지도',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              onDismiss: _onSettingBarClose,
            ),
          SlideTransition(
            position: _settingBarAnimation,
            child: SettingBarScreen(close: _onSettingBarClose),
          ),
        ],
      ),
    );
  }
}
