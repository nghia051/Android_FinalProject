class User {
  String email;
  String password;
  String username;
  String profileImageUrl;
  String aboutUser;

  User({ required this.email, required this.password, required this.username, required this.profileImageUrl,
      required this.aboutUser});

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
      'profileImageUrl': profileImageUrl,
      'aboutUser': aboutUser,
    };
  }
}
