class CafeModel {
  final String name;
  final String address;
  final double distance;
  final String openingTime;
  final String closingTime;
  final String holidays;
  final String imageUri;

  CafeModel({
    required this.name,
    required this.address,
    required this.distance,
    required this.openingTime,
    required this.closingTime,
    required this.holidays,
    required this.imageUri,
  });

  CafeModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        address = json['address'],
        distance = json['distance'],
        openingTime = json['openingTime'],
        closingTime = json['closingTime'],
        holidays = json['holidays'],
        imageUri = json['imageUri'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'distance': distance,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'holidays': holidays,
      'imageUri': imageUri,
    };
  }
}
