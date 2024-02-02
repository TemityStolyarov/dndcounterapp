import 'package:dndcounterapp/components/chat_bubble/in_chat_bubble.dart';
import 'package:dndcounterapp/components/chat_bubble/out_chat_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:dndcounterapp/pages/auth_page/error_bubble.dart';
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

  void recoveryPassword() {}

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

      if (e.code == 'user-not-found') {
        errorDialog('Такого нет в списках');
      } else if (e.code == 'invalid-email') {
        errorDialog('Указана неверная почта');
      } else if (e.code == 'invalid-credential') {
        errorDialog('Неправильный пароль');
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
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 64,
            horizontal: 32,
          ),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Ты бодрым шагом входишь в уже знакомую тебе таверну:',
                  style: TextStyle(
                    color: ColorPalette.fontBaseColor,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 48),
                Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 112,
                        top: 16,
                      ),
                      child: InChatBubble(
                        backgroundColor: ColorPalette.cubeColor,
                        child: Text(
                          'Рад приветствовать тебя! Ты же тот самый, напомни-ка..',
                          style: TextStyle(
                            color: ColorPalette.fontAltColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      isAntiAlias: true,
                      scale: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                OutChatBubble(
                  backgroundColor: ColorPalette.cardColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        autofocus: true,
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Логин',
                          labelStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        autofocus: true,
                        controller: passwordController,
                        obscureText: textObscure,
                        decoration: InputDecoration(
                          labelText: 'Пароль',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: InkWell(
                              onTapDown: (details) {
                                setState(() {
                                  textObscure = false;
                                });
                              },
                              onTapUp: (details) {
                                setState(() {
                                  textObscure = true;
                                });
                              },
                              child: Icon(
                                textObscure
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye_rounded,
                                color: ColorPalette.fontAltColor,
                              ),
                            ),
                          ),
                          labelStyle: const TextStyle(fontSize: 14),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                OutChatBubble(
                  backgroundColor: ColorPalette.cardColor,
                  child: InkWell(
                    onTap: doLogin,
                    child: const Text(
                      'А теперь тащи мне мое любимое пиво!',
                      style: TextStyle(
                        color: ColorPalette.fontBaseColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ни разу не был в пати? Скорее ',
                      style: TextStyle(
                        color: ColorPalette.fontAltColor,
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      overlayColor: const MaterialStatePropertyAll(
                        Colors.transparent,
                      ),
                      child: const Text(
                        'регистрируйся',
                        style: TextStyle(
                          color: ColorPalette.badgeHitLabel,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Text(
                      '!',
                      style: TextStyle(
                        color: ColorPalette.fontAltColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Забыл пароль? Тогда ',
                      style: TextStyle(
                        color: ColorPalette.fontAltColor,
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: recoveryPassword,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      overlayColor: const MaterialStatePropertyAll(
                        Colors.transparent,
                      ),
                      child: const Text(
                        'восстанови ',
                        style: TextStyle(
                          color: ColorPalette.badgeHitLabel,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Text(
                      'его!',
                      style: TextStyle(
                        color: ColorPalette.fontAltColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
