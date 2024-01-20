import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadgeAR extends StatelessWidget {
  final String info;
  final Color color;

  const StatBadgeAR({
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
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 3,
              left: 4,
              right: 4,
            ),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorPalette.cardColor,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
