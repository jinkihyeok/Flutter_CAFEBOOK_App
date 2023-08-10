import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../detailpage/models/cafe_model.dart';
import '../../detailpage/view_models/cafe_vm.dart';
import '../../detailpage/views/detailScreen.dart';
import '../../home/views/search_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late GoogleMapController _mapController;

  final LatLng _center = const LatLng(37.3433, 127.9170);

  final APIService _apiService = APIService();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onSearchBarTap(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );
  }

  void _onDetailTap() {
  Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          cafe: _selectedCafe!,
        ),
      ),
    );
  }

  Set<Marker> _markers = {};

  Cafe? _selectedCafe;

  void _loadMarkers() async {
    final cafes = await ref.read(cafesProvider.future);
    Set<Marker> tempMarkers = {};

    for (var cafe in cafes) {
      try {
        final latLngData = await _apiService.getLatLngFromAddress(cafe.address);
        if (latLngData != null && latLngData["lat"] != null && latLngData["lng"] != null) {
          final position = LatLng(latLngData["lat"], latLngData["lng"]);
          tempMarkers.add(
            Marker(
              markerId: MarkerId(cafe.name),
              position: position,
              onTap: () {
                setState(() {
                  _selectedCafe = cafe;
                });
              },
              infoWindow: InfoWindow(
                title: cafe.name,
              ),
            ),
          );
        }
      } catch (error) {
        print("Error fetching LatLng for cafe ${cafe.name}: $error");
      }
    }

    setState(() {
      _markers = tempMarkers;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
            right: Sizes.size14,
          ),
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
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            onTap: (position) {
              setState(() {
                _selectedCafe = null;
              });
            },
          ),
          if (_selectedCafe != null)
            Positioned(
              bottom: Sizes.size80,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
                child: GestureDetector(
                  onTap: _onDetailTap,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Sizes.size12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: Sizes.size8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    height: 110,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CachedNetworkImage(
                            height: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: _selectedCafe!.imageUri,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(Sizes.size14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_selectedCafe!.name, style: const TextStyle(fontWeight: FontWeight.w600),),
                                    const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      size: Sizes.size16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Gaps.v20,
                                Text('${_selectedCafe!.lat}, ${_selectedCafe!.lng}'),
                                Text('${_selectedCafe!.openingTime} ~ ${_selectedCafe!.closingTime}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
