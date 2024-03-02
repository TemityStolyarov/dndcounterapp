import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/userdata.dart';
import 'package:dndcounterapp/pages/user_page/user_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final userRepository = UserRepository();

    return FutureBuilder(
      future: userRepository.getUserData(user.email!),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Получение данных пользователя
        final Map<String, dynamic> userData = snapshot.data!;

        if (userData.containsKey('error')) {
          return Text(userData['error']);
        }

        final UserDataModel userModel = UserDataModel.fromJson(userData);

        return UserPageScreen(
          linkedTables: userModel.linkedTables,
          nickname: userModel.nickname,
          userEmail: user.email!,
          signOut: () {
            FirebaseAuth.instance.signOut();
          },
        );
      },
    );
  }
}
