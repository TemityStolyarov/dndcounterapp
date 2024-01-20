import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

enum SpellStatBadgeType {
  dmg(
    colorLabel: ColorPalette.badgeDmgLabel,
    colorBackground: ColorPalette.badgeDmgBackground,
  ),
  mechanics(
    colorLabel: ColorPalette.badgeDmgBuffLabel,
    colorBackground: ColorPalette.badgeDmgBuffBackground,
  ),
  usual(
    colorLabel: ColorPalette.badgeKdLabel,
    colorBackground: ColorPalette.badgeKdBackground,
  ),
  cast(
    colorLabel: ColorPalette.badgeHitLabel,
    colorBackground: ColorPalette.badgeHitBackground,
  );

  final Color colorLabel;
  final Color colorBackground;

  const SpellStatBadgeType({
    required this.colorLabel,
    required this.colorBackground,
  });
}

class SpellStatBadge extends StatelessWidget {
  const SpellStatBadge({
    super.key,
    required this.type,
    required this.label,
  });

  final SpellStatBadgeType type;
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
