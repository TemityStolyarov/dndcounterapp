import 'dart:async';
import 'dart:math';

import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class Dice extends StatefulWidget {
  final int d;
  final bool colorScheme;

  const Dice({
    super.key,
    required this.d,
    required this.colorScheme,
  });

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int result = 0;
  bool? isRolling;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (isRolling == true)
          ? null
          : () async {
              setState(() {
                isRolling = true;
              });
              _playAnimation();
            },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: (isRolling != null && isRolling == true)
              ? ColorPalette.cubeColor
              : result == widget.d
                  ? ColorPalette.critLuckyCubeColor
                  : result == 1
                      ? ColorPalette.critUnluckyCubeColor
                      : ColorPalette.cubeColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: ColorPalette.fontBaseColor.withOpacity(0.7),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.colorScheme
                  ? ColorPalette.alternativeshadowColor
                  : ColorPalette.shadowColor,
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.toString(),
              style: TextStyle(
                fontSize: 20,
                color: (isRolling != null && isRolling == true)
                    ? ColorPalette.cubeRolling
                    : result == widget.d
                        ? ColorPalette.critLucky
                        : result == 1
                            ? ColorPalette.critUnlucky
                            : ColorPalette.fontBaseColor,
                fontWeight: (isRolling != null && isRolling == false)
                    ? (result == 1 || result == widget.d)
                        ? FontWeight.bold
                        : FontWeight.normal
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _random(d) {
    int result = 0;
    result = Random().nextInt(d) + 1;
    return result;
  }

  void _playAnimation() async {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {
        result = (Random().nextInt(widget.d) + 1);
      });
    });

    await Future.delayed(const Duration(seconds: 1), () {
      _timer?.cancel();
    });

    setState(() {
      isRolling = false;
      result = _random(widget.d);
    });
  }
}
