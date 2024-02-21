import 'package:dndcounterapp/pages/auth_page/register_page/register_page_screen.dart';
import 'package:flutter/material.dart';

class RegisterPageStory extends StatefulWidget {
  const RegisterPageStory({super.key});

  @override
  State<RegisterPageStory> createState() => _RegisterPageStoryState();
}

class _RegisterPageStoryState extends State<RegisterPageStory> {
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
