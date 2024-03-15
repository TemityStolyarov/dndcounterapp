import 'package:dndcounterapp/core/models/user_data_model.dart';
import 'package:dndcounterapp/pages/user_page/user_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class UserPageScreenStory extends StatelessWidget {
  const UserPageScreenStory({super.key, required this.knobs});

  final KnobsBuilder knobs;

  @override
  Widget build(BuildContext context) {
    final user = UserDataModel.fromJson({
      'email': 'test@mail.com',
      'nickname': 'TestNickname',
      'linked_tables': ['1', '2'],
    });

    return UserPageScreen(
      userData: UserDataModelConverted(
        email: user.email,
        linkedTables: [],
        nickname: 'Nickname',
        userId: 'uid',
        lightTheme: knobs.boolean(
          label: 'Тема',
          initial: true,
        ),
      ),
      signOut: () => print('Logged out!'),
    );
  }
}
