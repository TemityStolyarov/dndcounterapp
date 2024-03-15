import 'package:dndcounterapp/pages/recovery_page/recovery_page_screen.dart';
import 'package:flutter/material.dart';

class RecoveryPageScreenStory extends StatefulWidget {
  const RecoveryPageScreenStory({super.key});

  @override
  State<RecoveryPageScreenStory> createState() => _RecoveryPageScreenStoryState();
}

class _RecoveryPageScreenStoryState extends State<RecoveryPageScreenStory> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecoveryPageScreen(
      emailController: emailController,
      doRecovery: () => print('doRecovery'),
      goToAuth: () => print('goToAuth'),
    );
  }
}
