import 'package:dndcounterapp/core/models/userdata.dart';
import 'package:dndcounterapp/pages/user_page/user_page_screen.dart';
import 'package:flutter/material.dart';

class UserPageScreenStory extends StatelessWidget {
  const UserPageScreenStory({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserDataModel.fromJson({
      'email': 'test@mail.com',
      'nickname': 'TestNickname',
      'linked_tables': ['1', '2'],
    });

    return UserPageScreen(
      linkedTables: user.linkedTables,
      nickname: user.nickname,
      userEmail: user.email,
      signOut: () => print('Logged out!'),
    );
  }
}
