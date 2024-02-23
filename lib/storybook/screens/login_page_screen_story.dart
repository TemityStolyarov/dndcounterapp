import 'package:dndcounterapp/pages/login_page/login_page_screen.dart';
import 'package:flutter/material.dart';

class LoginPageScreenStory extends StatefulWidget {
  const LoginPageScreenStory({super.key});

  @override
  State<LoginPageScreenStory> createState() => _LoginPageScreenStoryState();
}

class _LoginPageScreenStoryState extends State<LoginPageScreenStory> {
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
    return LoginPageScreen(
      emailController: emailController,
      passwordController: passwordController,
      doLogin: () => print('doLogin'),
      recoveryPassword: () => print('recoveryPassword'),
    );
  }
}
