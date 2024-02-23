import 'package:dndcounterapp/components/chat_bubble/in_chat_bubble.dart';
import 'package:dndcounterapp/components/chat_bubble/out_chat_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class RegisterPageScreen extends StatefulWidget {
  const RegisterPageScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.doRegister,
    required this.goToAuth,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback doRegister;
  final VoidCallback goToAuth;

  @override
  State<RegisterPageScreen> createState() => _RegisterPageScreenState();
}

class _RegisterPageScreenState extends State<RegisterPageScreen> {
  bool textObscure = true;

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
                    'Ты осторожно подходишь к стойке регистрации:',
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
                            'Добро пожаловать! Представься, пожалуйста, я занесу тебя в списки',
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
                          controller: widget.emailController,
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
                        const SizedBox(height: 16),
                        TextField(
                          autofocus: true,
                          controller: widget.passwordController,
                          obscureText: textObscure,
                          decoration: InputDecoration(
                            labelText: 'Пароль',
                            suffixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                  InkWell(
                    onTap: widget.doRegister,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    overlayColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    child: const OutChatBubble(
                      backgroundColor: ColorPalette.cardColor,
                      child: Text(
                        'Вперед к приключениям!',
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
                        'Уже играл с нами? Тогда ',
                        style: TextStyle(
                          color: ColorPalette.fontAltColor,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: widget.goToAuth,
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
