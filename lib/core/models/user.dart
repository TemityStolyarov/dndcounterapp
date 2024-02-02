class UserModel {
  final String? id;
  final String email;
  final String nickname;

  UserModel({
    this.id,
    required this.email,
    required this.nickname,
  });

  toJson() {
    return {
      'email': email,
      'nickname': nickname,
    };
  }
}
