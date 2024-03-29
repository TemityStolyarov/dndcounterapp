import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class ErrorBubble extends StatelessWidget {
  const ErrorBubble({super.key, required this.errorMessage});

  final String errorMessage;

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
            Icons.cancel_rounded,
            color: ColorPalette.critUnlucky,
            size: 40,
          ),
          const SizedBox(height: 12),
          Text(
            errorMessage,
            style: const TextStyle(
              color: ColorPalette.fontAltColor,
            ),
          ),
        ],
      ),
    );
  }
}

