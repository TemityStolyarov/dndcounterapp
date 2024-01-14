import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_ar.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadgeHP extends StatBadgeAR {
  final int hpModifier;
  final int hp;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final bool isEnabled;

  const StatBadgeHP({
    super.key,
    required this.onReturnDefaultHP,
    required this.onSetHP,
    required this.hpModifier,
    required this.hp,
    required this.isEnabled,
    required super.info,
    required super.color,
  });

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 84;

    return Row(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            color: isEnabled
                ? ColorPalette.cardColor
                : ColorPalette.cardColor.withOpacity(0.3),
            border: Border.all(
              color: ColorPalette.alternativeshadowColor,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              InkWell(
                onTap: onReturnDefaultHP,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: SizedBox(
                    child: Text(
                      hp.toString(),
                      style: TextStyle(
                        color: hp != (hp + hpModifier)
                            ? ColorPalette.cubeRolling.withOpacity(0.5)
                            : ColorPalette.fontBaseColor,
                        fontWeight: FontWeight.w500,
                        height: 14 / 12,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onSetHP,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorPalette.shadowColor,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: color,
                    boxShadow: [
                      BoxShadow(
                        color: (hp + hpModifier) <= 0
                            ? Colors.transparent
                            : hp > (hp + hpModifier)
                                ? ColorPalette.critUnlucky.withOpacity(0.4)
                                : hp < (hp + hpModifier)
                                    ? ColorPalette.attHP.withOpacity(0.4)
                                    : Colors.transparent,
                        offset: const Offset(0, 0),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    child: Text(
                      info,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: ColorPalette.cardColor,
                        fontWeight: FontWeight.w500,
                        height: 14 / 12,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
