import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiKeys {

  static String get apiKey {
    if (Platform.isAndroid) {
      return dotenv.env['GOOGLE_API_KEY_ANDROID']!;
    } else if (Platform.isIOS) {
      return dotenv.env['GOOGLE_API_KEY_IOS']!;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

class APIService {
  final String _baseUrl = "https://maps.googleapis.com/maps/api";
  final String _endPoint = "/geocode/json";

  Future<dynamic> getLatLngFromAddress(String address) async {
    final String apiUrl = "$_baseUrl$_endPoint?address=$address&key=${ApiKeys.apiKey}";

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedResponse = json.decode(response.body);

      if (decodedResponse["status"] == "OK") {
        return decodedResponse["results"][0]["geometry"]["location"];
      } else {
        throw Exception("Error fetching data from Google Maps API: ${decodedResponse["status"]}");
      }
    } else {
      throw Exception("Failed to load data from Google Maps API");
    }
  }
}