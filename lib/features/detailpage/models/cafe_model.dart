import 'package:cloud_firestore/cloud_firestore.dart';

class Cafe {
  final String id;
  final String name;
  final String address;
  final double geoPoint;
  final String openingTime;
  final String closingTime;
  final String imageUri;

  Cafe({
    required this.id,
    required this.name,
    required this.address,
    required this.geoPoint,
    required this.openingTime,
    required this.closingTime,
    required this.imageUri,
  });

  factory Cafe.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Cafe(
      id: doc.id,
      name: data['name'],
      address: data['address'],
      geoPoint: data['geoPoint'],
      openingTime: data['openingTime'],
      closingTime: data['closingTime'],
      imageUri: data['imageUri'],
    );
  }
}
