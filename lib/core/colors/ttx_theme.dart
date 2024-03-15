import 'dart:ui';

import 'package:flutter/material.dart';

class TTxTheme {
  final Color backgroundColorPrimary;
  final Color backgroundColorSecondary;
  final Color backgroundColorTretriary;

  final Color fontColorPrimary;
  final Color fontColorLabel;

  TTxTheme({
    required this.backgroundColorPrimary,
    required this.backgroundColorSecondary,
    required this.backgroundColorTretriary,
    required this.fontColorPrimary,
    required this.fontColorLabel,
  });

  static const regular12 = TextStyle(
    color: Colors.transparent,
    fontVariations: [FontVariation('wght', 400.0)],
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
  );
  static const medium12 = TextStyle(
    color: Colors.transparent,
    fontVariations: [FontVariation('wght', 500.0)],
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w500,
  );
  static const bold12 = TextStyle(
    color: Colors.transparent,
    fontVariations: [FontVariation('wght', 600.0)],
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w600,
  );
}

class ColorTheme {
  static final light = TTxTheme(
    backgroundColorPrimary: const Color(0xFFEAEAF8),
    backgroundColorSecondary: const Color(0xFFE3E3F6),
    backgroundColorTretriary: const Color(0xFFD6D6EA),
    fontColorPrimary: const Color(0xFF2D2F42),
    fontColorLabel: const Color(0xFF737C88),
  );

  static final dark = TTxTheme(
    backgroundColorPrimary: const Color(0xFF58606C),
    backgroundColorSecondary: const Color(0xFF202328),
    backgroundColorTretriary: const Color(0xFF30353A),
    fontColorPrimary: const Color(0xFFE3E3F6),
    fontColorLabel: const Color(0xFF737C88),
  );
}
