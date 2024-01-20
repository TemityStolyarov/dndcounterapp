import 'package:dndcounterapp/components/character_card/character_stat_blocks/status_effects/status_effect_item.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

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
  final VoidCallback onTapStatusRollDebuff;
  final VoidCallback onTapStatusRollBuff;
  final VoidCallback onTapStatusProvocated;

  final VoidCallback onClearStatusKdDebuff;
  final VoidCallback onClearStatusKdBuff;
  final VoidCallback onClearStatusRoped;
  final VoidCallback onClearStatusDmgBuff;
  final VoidCallback onClearStatusFreezed;
  final VoidCallback onClearStatusRollDebuff;
  final VoidCallback onClearStatusRollBuff;
  final VoidCallback onClearStatusProvocated;

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
    required this.onTapStatusRollDebuff,
    required this.onTapStatusRollBuff,
    required this.onTapStatusProvocated,
    required this.onClearStatusKdDebuff,
    required this.onClearStatusKdBuff,
    required this.onClearStatusRoped,
    required this.onClearStatusDmgBuff,
    required this.onClearStatusFreezed,
    required this.onClearStatusRollDebuff,
    required this.onClearStatusRollBuff,
    required this.onClearStatusProvocated,
    this.alignment = StatusEffectsRowAlignment.start,
    this.spacer = 0,
  });

  @override
  Widget build(BuildContext context) {
    const width = 28.0;
    const height = 28.0;
    const padding = 3.0;
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
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusKdDebuff,
          onTap: onClearStatusKdDebuff,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusKdDebuff != '' &&
                character.statusKdDebuff != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusKdDebuff,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusKdBuff,
          onTap: onClearStatusKdBuff,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull:
                character.statusKdBuff != '' && character.statusKdBuff != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusKdBuff,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusProvocated,
          onTap: onClearStatusProvocated,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusProvocated != '' &&
                character.statusProvocated != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusProvocated,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusRoped,
          onTap: onClearStatusRoped,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull:
                character.statusRoped != '' && character.statusRoped != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusRoped,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusDmgBuff,
          onTap: onClearStatusDmgBuff,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusDmgBuff != '' &&
                character.statusDmgBuff != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusDmgBuff,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusFreezed,
          onTap: onClearStatusFreezed,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusFreezed != '' &&
                character.statusFreezed != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusFreezed,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusRollDebuff,
          onTap: onClearStatusRollDebuff,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusRollDebuff != '' &&
                character.statusRollDebuff != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusRollDebuff,
          ),
        ),
        if (alignment != StatusEffectsRowAlignment.spaceBetween)
          SizedBox(width: spacer),
        InkWell(
          onLongPress: onTapStatusRollBuff,
          onTap: onClearStatusRollBuff,
          child: StatusEffectItem(
            width: width,
            height: height,
            border: border,
            shadow: shadow,
            character: character,
            padding: padding,
            isNotEmptyAndNotNull: character.statusRollBuff != '' &&
                character.statusRollBuff != null,
            isEnabled: character.isEnabled,
            type: StatusEffectItemType.statusRollBuff,
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
