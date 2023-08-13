class UserProfileModel {
  final String uid;
  final String email;
  final String name;
  final List<String> favorites;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.favorites,
  });

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '',
        favorites = [];

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        name = json['name'],
        favorites = List<String>.from(json['favorites'] ?? []);

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'favorites': favorites,
    };
  }
}
