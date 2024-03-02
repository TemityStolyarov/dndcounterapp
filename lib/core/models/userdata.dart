class UserDataModel {
  final List<String> linkedTables;
  final String email;
  final String nickname;

  UserDataModel({
    required this.linkedTables,
    required this.email,
    required this.nickname,
  });

  toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'linked_tables': linkedTables,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      email: json['email'],
      nickname: json['nickname'],
      linkedTables: json['linked_tables'],
    );
  }
}
