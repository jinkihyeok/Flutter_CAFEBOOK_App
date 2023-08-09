import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../detailpage/view_models/cafe_vm.dart';
import '../../home/views/search_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  late GoogleMapController _mapController;

  final LatLng _center = const LatLng(37.3433, 127.9170);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onSearchBarTap(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );
  }

  Set<Marker> _markers = {};

  void _loadMarkers() async {
    final cafes = await ref.read(cafesProvider.future);
    setState(
      () {
        _markers = cafes
            .map(
              (cafe) => Marker(
                markerId: MarkerId(cafe.name),
                position: LatLng(cafe.lat, cafe.lng),
                infoWindow: InfoWindow(
                  title: cafe.name,
                  snippet: cafe.address,
                  onTap: () {},
                ),
              ),
            )
            .toSet();
      },
    );
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
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _markers,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
