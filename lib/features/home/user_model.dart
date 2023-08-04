class UserProfileModel {
  final String uid;
  final String email;
  final String name;

  UserProfileModel(
      {required this.uid, required this.email, required this.name});

  UserProfileModel.empty()
      : uid = '',
        email = '',
        name = '';
}
