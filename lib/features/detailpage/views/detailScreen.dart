import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/constants/gaps.dart';
import 'package:caffe_app/features/home/view_models/user_vm.dart';
import 'package:caffe_app/util/distances_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../constants/sizes.dart';
import '../models/cafe_model.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final Cafe cafe;

  const DetailScreen({super.key, required this.cafe});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _setupFavoriteStatus();
  }

  void _setupFavoriteStatus() async {
    final cafeId = widget.cafe.id;

    List<String> userFavorites =
        await ref.read(usersProvider.notifier).getUserFavorites();
    setState(() {
      isFavorite = userFavorites.contains(cafeId);
    });
  }

  void _toggleFavorite() async {
    final cafeId = widget.cafe.id;

    if (!isFavorite) {
      await ref.read(usersProvider.notifier).addFavorite(cafeId);
    } else {
      await ref.read(usersProvider.notifier).deleteFavorite(cafeId);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cafe.name,
          style: const TextStyle(
              fontSize: Sizes.size20, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size14,
            ),
            child: IconButton(
              onPressed: _toggleFavorite,
              icon: FaIcon(
                isFavorite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                size: Sizes.size24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 300,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: widget.cafe.imageUri,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16,
            ),
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.solidStar,
                          size: Sizes.size16,
                        ),
                        Gaps.h4,
                        Text(
                          '${(widget.cafe.likes).toStringAsFixed(1)} / 5',
                        ),
                      ],
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const FaIcon(FontAwesomeIcons.map),
                        Gaps.h14,
                        Text(widget.cafe.location),
                        const SizedBox(
                          height: 25,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        DistanceWidget(cafe: widget.cafe),
                        const SizedBox(
                          height: 25,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        Text(widget.cafe.address),
                      ],
                    ),
                    Gaps.v16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const FaIcon(FontAwesomeIcons.clock),
                        Gaps.h14,
                        Text(
                          '${widget.cafe.openingTime} ~ ${widget.cafe.closingTime}',
                        ),
                        const SizedBox(
                          height: 25,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 5,
                            endIndent: 5,
                          ),
                        ),
                        const Text(
                          '매주 월요일 휴무',
                        ),
                      ],
                    ),
                    Gaps.v40,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Sizes.size16),
                            child: Text(
                              "I N F O",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v24,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_naver.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_daum.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/google.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_instagram.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v48,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Sizes.size16),
                            child: Text(
                              "M A P",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gaps.v24,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Sizes.size40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_naver_map.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_kakao_map.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                              ),
                              child: Image.asset(
                                'assets/icons/logo_google_map.png',
                                scale: 0.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
