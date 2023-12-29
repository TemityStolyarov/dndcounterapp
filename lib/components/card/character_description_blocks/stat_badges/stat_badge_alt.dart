import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadgeAlt extends StatelessWidget {
  final String info;
  final Color color;

  const StatBadgeAlt({
    super.key,
    required this.info,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.shadowColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              // vertical: 2,
              horizontal: 4,
            ),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorPalette.cardColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
