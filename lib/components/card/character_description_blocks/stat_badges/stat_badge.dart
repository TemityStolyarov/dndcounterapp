import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class StatBadge extends StatelessWidget {
  final String? label;
  final String info;
  final Color color;

  const StatBadge({
    super.key,
    required this.label,
    required this.info,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 114;
    const double whitePartWidth = maxWidth - 70;

    return Row(
      children: [
        Container(
          width: maxWidth,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.alternativeshadowColor,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  top: 2,
                  bottom: 2,
                ),
                child: SizedBox(
                  width: whitePartWidth,
                  child: Text(
                    label ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      height: 14 / 12,
                    ),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
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
