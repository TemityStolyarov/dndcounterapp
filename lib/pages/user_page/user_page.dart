import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/user_data_model.dart';
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
      builder: (context, AsyncSnapshot<UserDataModelConverted> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Получение данных пользователя
        final UserDataModelConverted userData = snapshot.data!;

        // if (userData.containsKey('error')) {
        //   return Text(userData['error']);
        // }
        // TODO: обработать ошибки

        return UserPageScreen(
          userData: userData,
          signOut: () {
            FirebaseAuth.instance.signOut();
          },
        );
      },
    );
  }
}
