import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class UserPageScreen extends StatelessWidget {
  const UserPageScreen({
    super.key,
    required this.linkedTables,
    required this.signOut,
    required this.userEmail,
    required this.nickname,
  });

  final List<String> linkedTables;
  final VoidCallback signOut;
  final String userEmail;
  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Column(
        children: [
          SelectableText(nickname.toString()),
          GestureDetector(
            // onSecondaryTap: () {
            //   print('123');
            // },
            child: const Icon(
              Icons.ac_unit,
            ),
          ),
          ElevatedButton(
            onPressed: signOut,
            child: Text('Logout from $userEmail'),
          ),
        ],
      ),
    );
  }
}
