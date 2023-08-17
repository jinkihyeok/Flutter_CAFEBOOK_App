import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
  int selectedLocationIndex = -1;

  final TextEditingController _textEditingController = TextEditingController();

  void _onSearchBarTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSearchChanged(String value) {
    int matchedIndex = locations.indexWhere((location) => location == value);

    setState(
      () {
        if (matchedIndex != -1) {
          selectedLocationIndex = matchedIndex;
        } else {
          selectedLocationIndex = -1;
        }
      },
    );
  }

  void _onSearchSubmitted(String value) {}

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onScafoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScafoldTap,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leading: IconButton(
            iconSize: Sizes.size32,
            icon: const FaIcon(
              FontAwesomeIcons.circleXmark,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
                vertical: Sizes.size20,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size20,
                vertical: Sizes.size20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Sizes.size20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '카페 또는 지역으로\n검색해주세요.',
                    style: TextStyle(
                      fontSize: Sizes.size28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  GestureDetector(
                    onTap: _onSearchBarTap,
                    child: CupertinoSearchTextField(
                      onSuffixTap: () {
                        _textEditingController.clear();
                        setState(() => selectedLocationIndex = -1);
                      },
                      controller: _textEditingController,
                      onChanged: _onSearchChanged,
                      onSubmitted: _onSearchSubmitted,
                      placeholder: '카페명 or 지역명 검색',
                      itemColor: Colors.black,
                      itemSize: Sizes.size24,
                      padding: const EdgeInsets.all(Sizes.size12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(Sizes.size12),
                      ),
                    ),
                  ),
                  Gaps.v20,
                  Wrap(
                    runSpacing: 15,
                    spacing: 8,
                    children: [
                      for (var index = 0; index < locations.length; index++)
                        GestureDetector(
                          onTap: () {
                            _textEditingController.text = locations[index];
                            setState(() => selectedLocationIndex = index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size14,
                              vertical: Sizes.size10,
                            ),
                            decoration: BoxDecoration(
                              color: index == selectedLocationIndex
                                  ? Colors.black
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.1),
                              ),
                              borderRadius: BorderRadius.circular(
                                Sizes.size32,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: Text(
                              locations[index],
                              style: TextStyle(
                                color: index == selectedLocationIndex
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, _textEditingController.text);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size20,
                      vertical: Sizes.size10,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.white,
                          size: Sizes.size16,
                        ),
                        Gaps.h8,
                        Text(
                          '검색',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
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
