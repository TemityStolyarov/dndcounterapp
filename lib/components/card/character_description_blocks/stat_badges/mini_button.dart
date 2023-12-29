import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class MiniButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const MiniButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 14,
        color: ColorPalette.cubeRolling,
      ),
    );
  }
}
