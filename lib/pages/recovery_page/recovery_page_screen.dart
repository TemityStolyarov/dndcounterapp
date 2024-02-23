import 'package:dndcounterapp/components/chat_bubble/in_chat_bubble.dart';
import 'package:dndcounterapp/components/chat_bubble/out_chat_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class RecoveryPageScreen extends StatelessWidget {
  const RecoveryPageScreen({
    super.key,
    required this.emailController,
    required this.doRecovery,
    required this.goToAuth,
  });

  final TextEditingController emailController;
  final VoidCallback doRecovery;
  final VoidCallback goToAuth;

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
