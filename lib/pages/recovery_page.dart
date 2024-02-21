import 'package:dndcounterapp/components/bubble/confirm_bubble.dart';
import 'package:flutter/material.dart';
import 'package:dndcounterapp/components/chat_bubble/in_chat_bubble.dart';
import 'package:dndcounterapp/components/chat_bubble/out_chat_bubble.dart';
import 'package:dndcounterapp/components/bubble/error_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RecoveryPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void doRecovery() async {
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
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      Navigator.pop(context);

      confirmDialog(
        'Сообщение с письмом для восстановления направлено на почту ${emailController.text}',
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'missing-email') {
        print(e.code);
        errorDialog('Почта не указана');
      } else if (e.code == 'invalid-email') {
        print(e.code);
        errorDialog('Неверный формат почты');
      } else {
        print(e.code);
        errorDialog('Что-то пошло не так: ${e.code}');
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

  void confirmDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmBubble(
          message: message,
        );
      },
    );
  }

  void goToAuth() {
    Navigator.pop(context);
    //Navigator.pushNamedAndRemoveUntil(context, '/auth', (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
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
                    'Ты хватаешься за голову:',
                    style: TextStyle(
                      color: ColorPalette.fontBaseColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const OutChatBubble(
                    backgroundColor: ColorPalette.cardColor,
                    child: Text(
                      'О нет, я забыл пароль!',
                      style: TextStyle(
                        color: ColorPalette.fontBaseColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
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
                            'Давай восстановлю тебе доступ! Напомни свою почту',
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
                            labelText: 'Почта',
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
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
                  InkWell(
                    onTap: doRecovery,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    overlayColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    child: const OutChatBubble(
                      backgroundColor: ColorPalette.cardColor,
                      child: Text(
                        'Ну как там, получается?',
                        style: TextStyle(
                          color: ColorPalette.fontBaseColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 176),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Вспомнил пароль? Тогда ',
                        style: TextStyle(
                          color: ColorPalette.fontAltColor,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: goToAuth,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        overlayColor: const MaterialStatePropertyAll(
                          Colors.transparent,
                        ),
                        child: const Text(
                          'можешь просто войти',
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
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// try {
//       FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
//       confirmDialog(
//           'Сообщение с письмом для восстановления направлено на почту ${emailController.text.isEmpty ? '<пустая почта>' : emailController.text}');
//     } on FirebaseAuthException catch (e) {
//       Navigator.pop(context);

//       if (e.code == 'invalid-email') {
//         print(e.code);
//         errorDialog('Указана неверная почта');
//       } else if (e.code == 'user-not-found') {
//         print(e.code);
//         errorDialog('Такого нет в списках');
//       } else if (e.code == 'invalid-credential') {
//         print(e.code);
//         errorDialog('Почта или пароль введены неверно');
//       } else {
//         print(e.code);
//         errorDialog('Что-то пошло не так');
//       }
//     }