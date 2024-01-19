import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadgeWrapped extends StatelessWidget {
  final String? label;
  final String info;
  final Color color;
  final bool isEnabled;
  final TextStyle? textStyle;

  const StatBadgeWrapped({
    super.key,
    required this.label,
    required this.info,
    required this.color,
    required this.isEnabled,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.shadowColor,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 3,
              bottom: 4,
              left: 3,
              right: 3,
            ),
            child: Text(
              info,
              textAlign: TextAlign.center,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 14,
                    color: ColorPalette.cardColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
