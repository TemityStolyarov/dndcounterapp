import 'package:dndcounterapp/components/bubble/confirm_bubble.dart';
import 'package:dndcounterapp/pages/recovery_page/recovery_page_screen.dart';
import 'package:flutter/material.dart';
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
    //Navigator.pushNamedAndRemoveUntil(context, '/checklogin', (route) => true);
  }

  @override
  Widget build(BuildContext context) {
    return RecoveryPageScreen(
      emailController: emailController,
      doRecovery: doRecovery,
      goToAuth: goToAuth,
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