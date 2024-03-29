import 'package:dndcounterapp/components/chat_bubble/in_chat_bubble.dart';
import 'package:dndcounterapp/components/chat_bubble/out_chat_bubble.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.doLogin,
    required this.recoveryPassword,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback doLogin;
  final VoidCallback recoveryPassword;

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
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
                    'Ты бодрым шагом входишь в уже знакомую таверну:',
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
                            'О, знакомое лицо! Ты же тот самый..',
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
                    onTap: widget.doLogin,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    overlayColor: const MaterialStatePropertyAll(
                      Colors.transparent,
                    ),
                    child: const OutChatBubble(
                      backgroundColor: ColorPalette.cardColor,
                      child: Text(
                        'А теперь тащи мне мое любимое пиво!',
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
                        onTap: widget.recoveryPassword,
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
      ),
    );
  }
}
