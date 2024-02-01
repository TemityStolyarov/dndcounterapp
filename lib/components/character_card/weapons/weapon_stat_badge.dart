import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

enum WeaponStatBadgeType {
  dmg(
    colorLabel: ColorPalette.badgeDmgLabel,
    colorBackground: ColorPalette.badgeDmgBackground,
  ),
  dmgBuff(
    colorLabel: ColorPalette.badgeDmgBuffLabel,
    colorBackground: ColorPalette.badgeDmgBuffBackground,
  ),
  kd(
    colorLabel: ColorPalette.badgeKdLabel,
    colorBackground: ColorPalette.badgeKdBackground,
  ),
  hit(
    colorLabel: ColorPalette.badgeHitLabel,
    colorBackground: ColorPalette.badgeHitBackground,
  );

  final Color colorLabel;
  final Color colorBackground;

  const WeaponStatBadgeType({
    required this.colorLabel,
    required this.colorBackground,
  });
}

class WeaponStatBadge extends StatelessWidget {
  const WeaponStatBadge({
    super.key,
    required this.type,
    required this.label,
  });

  final WeaponStatBadgeType type;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: type.colorBackground,
        border: Border.all(
          color: type.colorLabel.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 1,
          left: 4,
          right: 4,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: type.colorLabel,
            fontSize: 11,
            height: 0.9,
          ),
        ),
      ),
    );
  }
}
