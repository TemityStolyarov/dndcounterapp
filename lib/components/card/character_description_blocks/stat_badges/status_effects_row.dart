import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum StatusEffectsRowAlignment {
  start,
  center,
  spaceBetween,
  end,
}

class StatusEffectsRow extends StatelessWidget {
  final Character character;
  final VoidCallback onTapStatusKdDebuff;
  final VoidCallback onTapStatusKdBuff;
  final VoidCallback onTapStatusRoped;
  final VoidCallback onTapStatusDmgBuff;
  final VoidCallback onTapStatusFreezed;
  final VoidCallback onClearStatusKdDebuff;
  final VoidCallback onClearStatusKdBuff;
  final VoidCallback onClearStatusRoped;
  final VoidCallback onClearStatusDmgBuff;
  final VoidCallback onClearStatusFreezed;
  final StatusEffectsRowAlignment alignment;
  final double spacer;

  const StatusEffectsRow({
    super.key,
    required this.character,
    required this.onTapStatusKdDebuff,
    required this.onTapStatusKdBuff,
    required this.onTapStatusRoped,
    required this.onTapStatusDmgBuff,
    required this.onTapStatusFreezed,
    required this.onClearStatusKdDebuff,
    required this.onClearStatusKdBuff,
    required this.onClearStatusRoped,
    required this.onClearStatusDmgBuff,
    required this.onClearStatusFreezed,
    this.alignment = StatusEffectsRowAlignment.start,
    this.spacer = 0,
  });

  @override
  Widget build(BuildContext context) {
    const width = 28.0;
    const height = 28.0;
    const padding = 3.0;
    final backgroundColor = ColorPalette.backgroundColor.withOpacity(0.5);
    final backgroundColorOpacity =
        ColorPalette.backgroundColor.withOpacity(0.3);
    const backgroundColorActiveOpacityDefault = 1.0;
    const backgroundColorActiveOpacity = 0.4;
    final List<BoxShadow> shadow = [];
    final border = Border.all(
      style: BorderStyle.solid,
      color: ColorPalette.fontBaseColor.withOpacity(0.3),
      width: 0.5,
    );
    return Row(
      mainAxisAlignment: _parseStatusRowToRowAlignment(alignment),
      children: [
        if (character.initiative != -1 && character.initiative != null)
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color: ColorPalette.statusInitiativeBackground,
            ),
            child: Padding(
                padding: const EdgeInsets.all(padding),
                child: Center(
                  child: Text(
                    character.initiative.toString(),
                    style: const TextStyle(
                      color: ColorPalette.statusInitiativeLabel,
                      fontWeight: FontWeight.bold,
                      height: 18 / 14,
                      fontSize: 14,
                    ),
                  ),
                )),
          ),
        GestureDetector(
          onDoubleTap: onTapStatusKdDebuff,
          onTap: onClearStatusKdDebuff,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color: character.statusKdDebuff != '' &&
                      character.statusKdDebuff != null
                  ? character.isEnabled
                      ? ColorPalette.statusKdDebuffBackground
                          .withOpacity(backgroundColorActiveOpacityDefault)
                      : ColorPalette.statusKdDebuffBackground
                          .withOpacity(backgroundColorActiveOpacity)
                  : character.isEnabled
                      ? backgroundColor
                      : backgroundColorOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/icons/status_kd_debuff.svg',
                colorFilter: ColorFilter.mode(
                  character.statusKdDebuff != '' &&
                          character.statusKdDebuff != null
                      ? ColorPalette.statusKdDebuffLabel
                      : ColorPalette.fontBaseColor.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        if (character.statusKdDebuff != null &&
            alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        GestureDetector(
          onDoubleTap: onTapStatusKdBuff,
          onTap: onClearStatusKdBuff,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color:
                  character.statusKdBuff != '' && character.statusKdBuff != null
                      ? character.isEnabled
                          ? ColorPalette.statusKdBuffBackground
                              .withOpacity(backgroundColorActiveOpacityDefault)
                          : ColorPalette.statusKdBuffBackground
                              .withOpacity(backgroundColorActiveOpacity)
                      : character.isEnabled
                          ? backgroundColor
                          : backgroundColorOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/icons/status_kd_buff.svg',
                colorFilter: ColorFilter.mode(
                  character.statusKdBuff != '' && character.statusKdBuff != null
                      ? ColorPalette.statusKdBuffLabel
                      : ColorPalette.fontBaseColor.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        if (character.statusKdDebuff != null &&
            character.statusKdBuff != null &&
            alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        GestureDetector(
          onDoubleTap: onTapStatusRoped,
          onTap: onClearStatusRoped,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color: character.statusRoped != '' && character.statusRoped != null
                  ? character.isEnabled
                      ? ColorPalette.statusRopedBackground
                          .withOpacity(backgroundColorActiveOpacityDefault)
                      : ColorPalette.statusRopedBackground
                          .withOpacity(backgroundColorActiveOpacity)
                  : character.isEnabled
                      ? backgroundColor
                      : backgroundColorOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/icons/status_roped.svg',
                colorFilter: ColorFilter.mode(
                  character.statusRoped != '' && character.statusRoped != null
                      ? ColorPalette.statusRopedLabel
                      : ColorPalette.fontBaseColor.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        if (character.statusKdDebuff != null &&
            character.statusKdBuff != null &&
            character.statusRoped == null &&
            alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        GestureDetector(
          onDoubleTap: onTapStatusDmgBuff,
          onTap: onClearStatusDmgBuff,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color: character.statusDmgBuff != '' &&
                      character.statusDmgBuff != null
                  ? character.isEnabled
                      ? ColorPalette.statusDmgBuffBackground
                          .withOpacity(backgroundColorActiveOpacityDefault)
                      : ColorPalette.statusDmgBuffBackground
                          .withOpacity(backgroundColorActiveOpacity)
                  : character.isEnabled
                      ? backgroundColor
                      : backgroundColorOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/icons/status_dmg_buff.svg',
                colorFilter: ColorFilter.mode(
                  character.statusDmgBuff != '' &&
                          character.statusDmgBuff != null
                      ? ColorPalette.statusDmgBuffLabel
                      : ColorPalette.fontBaseColor.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        if (character.statusKdDebuff != null &&
            character.statusKdBuff != null &&
            character.statusRoped == null &&
            character.statusDmgBuff == null &&
            alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        GestureDetector(
          onDoubleTap: onTapStatusFreezed,
          onTap: onClearStatusFreezed,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: border,
              boxShadow: shadow,
              color: character.statusFreezed != '' &&
                      character.statusFreezed != null
                  ? character.isEnabled
                      ? ColorPalette.statusFreezedBackground
                          .withOpacity(backgroundColorActiveOpacityDefault)
                      : ColorPalette.statusFreezedBackground
                          .withOpacity(backgroundColorActiveOpacity)
                  : character.isEnabled
                      ? backgroundColor
                      : backgroundColorOpacity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: SvgPicture.asset(
                'assets/icons/status_freezed.svg',
                colorFilter: ColorFilter.mode(
                  character.statusFreezed != '' &&
                          character.statusFreezed != null
                      ? ColorPalette.statusFreezedLabel
                      : ColorPalette.fontBaseColor.withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _parseStatusRowToRowAlignment(StatusEffectsRowAlignment alignment) {
    switch (alignment) {
      case StatusEffectsRowAlignment.start:
        return MainAxisAlignment.start;
      case StatusEffectsRowAlignment.center:
        return MainAxisAlignment.center;
      case StatusEffectsRowAlignment.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      case StatusEffectsRowAlignment.end:
        return MainAxisAlignment.end;
    }
  }
}
