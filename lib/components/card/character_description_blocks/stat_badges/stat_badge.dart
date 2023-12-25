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
    return Row(
      children: [
        Container(
          width: 90,
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorPalette.alternativeshadowColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  top: 4,
                  bottom: 4,
                ),
                child: Text(
                  label ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorPalette.shadowColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: color,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    info,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
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
