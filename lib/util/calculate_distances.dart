import 'package:caffe_app/features/map_page/view_models/api_service.dart';
import 'package:caffe_app/features/map_page/view_models/user_location_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../features/detailpage/models/cafe_model.dart';

Future<int?> calculateDistances(WidgetRef ref, Cafe cafe) async {
  final APIService apiService = APIService();
  final userPosition = ref.read(userLocationProvider.notifier).state;
  double? distance;

  if (userPosition != null) {
      try {
        final latLngData = await apiService.getLatLngFromAddress(cafe.address);
        if (latLngData != null && latLngData["lat"] != null &&
            latLngData["lng"] != null) {
          final cafePosition = LatLng(latLngData["lat"], latLngData["lng"]);

           distance = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            cafePosition.latitude,
            cafePosition.longitude,
          ) / 1000;
          print("Distance between user and ${cafe.name} is ${distance.round()} km");
          return distance.round();
        }
      } catch (e) {
        print("Error fetching LatLng for cafe ${cafe.name}: $e");
      }
    } else {
    print("User location is not available");
  }
  return null;
}