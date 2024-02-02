import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
        },
        child: Text('Logout from ${user.email!}'),
      ),
    );
  }
}
