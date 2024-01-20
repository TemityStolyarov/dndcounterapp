import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadge extends StatelessWidget {
  final String? label;
  final String info;
  final Color color;
  final bool isEnabled;
  final TextStyle? textStyle;
  final TextStyle? textLabelStyle;

  const StatBadge({
    super.key,
    required this.label,
    required this.info,
    required this.color,
    required this.isEnabled,
    this.textStyle,
    this.textLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 106;
    const double colorPartWidth = 106 - 36;

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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Text(
                label ?? '',
                style: textLabelStyle ??
                    const TextStyle(
                      fontSize: 12,
                      height: 14 / 12,
                    ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                width: colorPartWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPalette.shadowColor,
                    width: 0.5,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  color: color,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
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
          ),
        ),
      ],
    );
  }
}
