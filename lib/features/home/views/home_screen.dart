import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:caffe_app/features/detailpage/views/detailScreen.dart';
import 'package:caffe_app/features/detailpage/view_models/cafe_vm.dart';
import 'package:caffe_app/features/home/views/search_screen.dart';
import 'package:caffe_app/features/home/views/setting_bar_screen.dart';
import 'package:caffe_app/features/home/views/widgets/grid_view_builder.dart';
import 'package:caffe_app/features/home/views/widgets/signature_description.dart';
import 'package:caffe_app/features/home/views/widgets/signature_image.dart';
import 'package:caffe_app/features/map_page/view_models/user_location_vm.dart';
import 'package:caffe_app/util/calculate_distances.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../detailpage/models/cafe_model.dart';
import '../../map_page/views/map_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  final tabs = [
    "인기순",
    "신규순",
    "가까운순",
  ];

  bool _showBarrier = false;

  final ScrollController _scrollController = ScrollController();

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
    _getCurrentLocation();
    cafesAsyncValue = ref.read(cafesProvider);
    _updateFilteredCafes();
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
    }
  }

  void _onTabBarTap(int index) {
    FocusScope.of(context).unfocus();
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

  String selectedLocation = "All";
  String selectedName = "";

  void _onSearchBarTap(BuildContext context) async {
    final List<String> locations = [
      "All",
      "지정면",
      "반곡관설동",
      "단계동",
      "무실동",
      "단구동",
      "행구동",
      "봉산동",
      "우산동",
      "태장1동",
      "태장2동",
      "학성동",
      "일산동",
      "명륜1동",
      "명륜2동",
      "개운동",
      "원인동",
      "중앙동",
      "문막읍",
      "소초면",
      "호저면",
      "부론면",
      "귀래면",
      "흥업면",
      "판부면",
      "신림면",
    ];
    final result = await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );

    if (result != null) {
      setState(() {
        if (locations.contains(result)) {
          selectedLocation = result;
          selectedName = "";
        } else {
          selectedLocation = "All";
          selectedName = result;
        }
      });
    }
  }

  void _onMapTap(filteredCafes) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MapScreen(cafes: filteredCafes),
      ),
    );
  }

  void _onDetailTap(Cafe selectedCafe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          cafe: selectedCafe,
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  _getCurrentLocation() async {
    try {
      Position? position = await getUserLocation();
      ref.read(userLocationProvider.notifier).state = position;
    } catch (e) {
      print(e);
    }
  }

  late AsyncValue<List<Cafe>> cafesAsyncValue;
  List<Cafe> filteredCafes = [];

  void _updateFilteredCafes() {
    if (cafesAsyncValue is AsyncData<List<Cafe>>) {
      final cafes = cafesAsyncValue.value;

      if (selectedLocation != 'All') {
        filteredCafes =
            cafes!.where((cafe) => cafe.location == selectedLocation).toList();
      } else {
        if (selectedName != '') {
          filteredCafes =
              cafes!.where((cafe) => cafe.name.contains(selectedName)).toList();
        } else {
          filteredCafes = cafes!;
        }
      }
      filteredCafes = getSortedCafesByLikes(filteredCafes);
    }
  }

  Future<List<Cafe>> getSortedCafesByDistance(
      WidgetRef ref, List<Cafe> filteredCafes) async {
    List<MapEntry<Cafe, int>> cafesWithDistances = [];

    for (final cafe in filteredCafes) {
      int? distance = await calculateDistances(ref, cafe);
      cafesWithDistances.add(MapEntry(cafe, distance!));
    }
    cafesWithDistances.sort((a, b) => a.value.compareTo(b.value));

    return cafesWithDistances.map((e) => e.key).toList();
  }

  List<Cafe> getSortedCafesByLikes(List<Cafe> cafes) {
    List<Cafe> sortedCafes = List.from(cafes);
    sortedCafes.sort((a, b) => b.likes.compareTo(a.likes));
    return sortedCafes;
  }

  List<Cafe> getSortedCafesByOpenDate(List<Cafe> cafes) {
    List<Cafe> sortedCafes = List.from(cafes);
    sortedCafes.sort((a, b) => b.openDate.compareTo(a.openDate));
    return sortedCafes;
  }

  @override
  Widget build(BuildContext context) {
    cafesAsyncValue = ref.watch(cafesProvider);
    _updateFilteredCafes();

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
            body: cafesAsyncValue.when(
              data: (cafes) {
                if (filteredCafes.isEmpty) {
                  return const Center(
                    child: Text(
                      '검색 결과가 없습니다.',
                      style: TextStyle(
                        fontSize: Sizes.size18,
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
                    child: TabBarView(
                      children: [
                        buildGridView(
                          filteredCafes,
                          _onRefresh,
                          _onDetailTap,
                        ),
                        buildGridView(
                          getSortedCafesByOpenDate(filteredCafes),
                          _onRefresh,
                          _onDetailTap,
                        ),
                        FutureBuilder<List<Cafe>>(
                          future: getSortedCafesByDistance(ref, filteredCafes),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (snapshot.hasData) {
                              final sortedCafes = snapshot.data!;
                              return GridView.builder(
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
                                itemCount: sortedCafes.length,
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () => _onDetailTap(sortedCafes[index]),
                                  child: Column(
                                    children: [
                                      SignatureImage(
                                        imageUri: sortedCafes[index].imageUri,
                                        id: sortedCafes[index].id,
                                      ),
                                      SignatureDescription(
                                        cafe: sortedCafes[index],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              error: (error, _) => Center(
                child: Text('$error'),
              ),
              loading: () => const CircularProgressIndicator(),
            ),
          ),
          Positioned(
            bottom: Sizes.size44,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _onMapTap(filteredCafes),
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
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size18,
                          ),
                          child: Text(
                            '지도',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
