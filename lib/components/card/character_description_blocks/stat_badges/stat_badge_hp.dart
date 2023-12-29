import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_ar.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadgeHP extends StatBadgeAR {
  final int hpModifier;
  final int hp;
  final VoidCallback onReturnDefaultHP;
  const StatBadgeHP({
    required this.onReturnDefaultHP,
    required this.hpModifier,
    required this.hp,
    super.key,
    required super.info,
    required super.color,
  });

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 76;

    return Row(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.alternativeshadowColor,
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPalette.shadowColor,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: color,
                  boxShadow: [
                    BoxShadow(
                      color: hp > (hp + hpModifier)
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
                    vertical: 1,
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
            ],
          ),
        ),
      ],
    );
  }
}
