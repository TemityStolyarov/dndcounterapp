import 'package:dndcounterapp/pages/login_page/login_page.dart';
import 'package:dndcounterapp/pages/user_page/user_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check if user is logged in
          if (snapshot.hasData) {
            // TODO Check for user or admin
            return const UserPage();
            // Check if user is NOT logged in
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
