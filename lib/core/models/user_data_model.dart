class UserDataModel {
  final List<dynamic> linkedTables;
  final String email;
  final String nickname;
  final bool lightTheme;

  UserDataModel({
    required this.linkedTables,
    required this.email,
    required this.nickname,
    required this.lightTheme,
  });

  toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'linked_tables': linkedTables,
      'light_theme': lightTheme,
    };
  }

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        email: json['email'],
        nickname: json['nickname'],
        linkedTables: json['linked_tables'],
        lightTheme: json['light_theme']);
  }
}

class UserDataModelConverted {
  final List<dynamic> linkedTables;
  final String email;
  final String nickname;
  final String userId;
  final bool lightTheme;

  UserDataModelConverted({
    required this.userId,
    required this.linkedTables,
    required this.email,
    required this.nickname,
    required this.lightTheme, 
  });
}
