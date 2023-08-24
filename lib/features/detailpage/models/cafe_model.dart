import 'package:cloud_firestore/cloud_firestore.dart';

class Cafe {
  final String id;
  final String name;
  final String address;
  final String location;
  final String openingTime;
  final String closingTime;
  final List<String> imageUri;
  final num openDate;
  final num likes;

  Cafe({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.openingTime,
    required this.closingTime,
    required this.imageUri,
    required this.openDate,
    required this.likes,
  });

  factory Cafe.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Cafe(
      id: doc.id,
      name: data['name'],
      address: data['address'],
      location: data['location'],
      openingTime: data['openingTime'],
      closingTime: data['closingTime'],
      imageUri: List<String>.from(data['imageUri']),
      openDate: data['openDate'],
      likes: data['likes'] ?? 0,
    );
  }
}
