import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/components/bubble/error_bubble.dart';
import 'package:dndcounterapp/pages/login_page/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool textObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void recoveryPassword() {
    Navigator.pushNamed(context, '/recovery');
  }

  void doLogin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: ColorPalette.cardColor,
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'invalid-email') {
        print(e.code);
        errorDialog('Указана неверная почта');
      } else if (e.code == 'user-not-found') {
        print(e.code);
        errorDialog('Такого нет в списках');
      } else if (e.code == 'invalid-credential') {
        print(e.code);
        errorDialog('Почта или пароль введены неверно');
      } else {
        print(e.code);
        errorDialog('Что-то пошло не так');
      }
    }
  }

  void errorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorBubble(
          errorMessage: errorMessage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageScreen(
      emailController: emailController,
      passwordController: passwordController,
      doLogin: doLogin,
      recoveryPassword: recoveryPassword,
    );
  }
}
