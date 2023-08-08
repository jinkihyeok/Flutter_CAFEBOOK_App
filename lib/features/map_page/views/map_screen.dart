import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../home/views/search_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  final LatLng _center = const LatLng(35.8714, 128.6014);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onSearchBarTap(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => const SearchScreen(),
    );
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
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
    );
}
}
