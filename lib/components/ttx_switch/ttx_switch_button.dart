import 'dart:ui';
import 'package:dndcounterapp/core/colors/ttx_theme.dart';
import 'package:flutter/material.dart';

class TTxSwitchButton extends StatelessWidget {
  final bool isDefault;
  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final String label;
  final TTxTheme theme;

  const TTxSwitchButton({
    super.key,
    required this.isDefault,
    required this.onTap,
    required this.borderRadius,
    required this.theme,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: isDefault ? theme.backgroundColorPrimary : Colors.transparent,
        ),
        child: Center(
          child: Text(
            label,
            style: isDefault
                ? TTxTheme.medium12.copyWith(color: theme.fontColorPrimary)
                : TTxTheme.regular12.copyWith(color: theme.fontColorLabel),
          ),
        ),
      ),
    );
  }
}
