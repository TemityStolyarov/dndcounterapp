import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharbookHeader extends StatelessWidget {
  const CharbookHeader({
    super.key,
    required this.charbookIndex,
    required this.charbookBox,
    required this.charbooks,
    required this.colorScheme,
    required this.onTapSection,
    required this.onTapCoins,
    required this.onStartBattleTap,
    required this.onEndBattleTap,
  });

  final int charbookIndex;
  final Box charbookBox;
  final List<CharBook> charbooks;
  final bool colorScheme;
  final VoidCallback onTapSection;
  final VoidCallback onTapCoins;
  final VoidCallback onStartBattleTap;
  final VoidCallback onEndBattleTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runSpacing: 32,
      children: [
        InkWell(
          onTap: onTapSection,
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: ColorPalette.backgroundSectionName,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme
                      ? ColorPalette.alternativeshadowColor
                      : ColorPalette.shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  charbooks[charbookIndex].name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.fontBaseColor,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        InkWell(
          onTap: onTapCoins,
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: ColorPalette.backgroundSectionName,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme
                      ? ColorPalette.alternativeshadowColor
                      : ColorPalette.shadowColor,
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      charbooks[charbookIndex].coins == null
                          ? '0'
                          : charbooks[charbookIndex].coins.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.fontBaseColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset('assets/icons/coin.svg'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 32),
        Container(
          width: 248,
          decoration: BoxDecoration(
            color: ColorPalette.backgroundSectionName,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme
                    ? ColorPalette.alternativeshadowColor
                    : ColorPalette.shadowColor,
                offset: const Offset(0, 5),
                blurRadius: 10,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Инициатива:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.fontBaseColor,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: onStartBattleTap,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset('assets/icons/battle.svg'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: onEndBattleTap,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: SvgPicture.asset('assets/icons/end_battle.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
