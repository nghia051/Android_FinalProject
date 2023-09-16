class User {
  String email;
  String password;
  String username;
  String profileImageUrl;

  String aboutUser;

  User(this.email, this.password, this.username, this.profileImageUrl,
      this.aboutUser);

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
