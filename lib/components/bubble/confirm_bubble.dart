import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class ConfirmBubble extends StatelessWidget {
  const ConfirmBubble({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: ColorPalette.attCharisma,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            message,
            style: const TextStyle(
              color: ColorPalette.fontAltColor,
            ),
          ),
        ],
      ),
    );
  }
}
