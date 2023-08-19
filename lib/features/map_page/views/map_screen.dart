import 'package:cached_network_image/cached_network_image.dart';
import 'package:caffe_app/features/map_page/view_models/api_service.dart';
import 'package:caffe_app/features/map_page/views/selected_cafe_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../detailpage/models/cafe_model.dart';
import '../../detailpage/views/detailScreen.dart';
import '../../home/view_models/user_vm.dart';
import '../../home/views/search_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  final List<Cafe> cafes;

  const MapScreen({Key? key, required this.cafes}) : super(key: key);

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
    final cafes = widget.cafes;
    Set<Marker> tempMarkers = {};

    for (var cafe in cafes) {
      try {
        final latLngData = await _apiService.getLatLngFromAddress(cafe.address);
        if (latLngData != null &&
            latLngData["lat"] != null &&
            latLngData["lng"] != null) {
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
    final userProfile = ref.watch(usersProvider).value;
    final isFavorite =
        userProfile?.favorites.contains(_selectedCafe?.id) ?? false;

    return Scaffold(
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
          Positioned(
              top: 50,
              left: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              )),
          if (_selectedCafe != null)
            SelectedCafeInfo(
                selectedCafe: _selectedCafe,
                isFavorite: isFavorite,
                onTap: _onDetailTap)
        ],
      ),
    );
  }
}
