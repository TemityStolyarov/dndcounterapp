import 'package:dndcounterapp/pages/register_page/register_page_screen.dart';
import 'package:flutter/material.dart';

class RegisterPageScreenStory extends StatefulWidget {
  const RegisterPageScreenStory({super.key});

  @override
  State<RegisterPageScreenStory> createState() =>
      _RegisterPageScreenStoryState();
}

class _RegisterPageScreenStoryState extends State<RegisterPageScreenStory> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RegisterPageScreen(
      emailController: emailController,
      passwordController: passwordController,
      doRegister: () => print('doRegister'),
      goToAuth: () => print('goToAuth'),
    );
  }
}
