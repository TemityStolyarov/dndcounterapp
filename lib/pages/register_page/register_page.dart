import 'package:dndcounterapp/components/bubble/error_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/core/data/user_repository.dart';
import 'package:dndcounterapp/core/models/user.dart';
import 'package:dndcounterapp/pages/register_page/register_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final userRepository = UserRepository();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void doRegister() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
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
        errorDialog('Что-то пошло не так: ${e.code}');
      }
    }

    try {
      final user = UserModel(
        email: emailController.text,
        nickname: emailController.text,
      );
      await userRepository.createUser(user);

      Navigator.pop(context);
      Navigator.pushNamed(context, '/checklogin');
    } catch (e) {
      Navigator.pop(context);
      print(e);
      errorDialog('Что-то пошло не так: ${e.toString()}');
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

  void goToAuth() {
    Navigator.pop(context);
    //Navigator.pushNamedAndRemoveUntil(context, '/checklogin', (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return RegisterPageScreen(
      emailController: emailController,
      passwordController: passwordController,
      doRegister: doRegister,
      goToAuth: goToAuth,
    );
  }
}
