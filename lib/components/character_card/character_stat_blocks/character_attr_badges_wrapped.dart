import 'package:dndcounterapp/components/character_card/character_stat_blocks/stat_badges/stat_badge_wrapped.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterAttrBadgesWrapped extends StatelessWidget {
  final Character character;
  final TextStyle? textStyle;

  const CharacterAttrBadgesWrapped({
    super.key,
    required this.character,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatBadgeWrapped(
                label: 'СИЛ',
                info:
                    '${character.strength} (${!modifier(character.strength).isNegative ? '+' : ''}${modifier(character.strength)})',
                color: ColorPalette.attStrength,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
              const Spacer(),
              StatBadgeWrapped(
                label: 'ЛОВ',
                info:
                    '${character.agility} (${!modifier(character.agility).isNegative ? '+' : ''}${modifier(character.agility)})',
                color: ColorPalette.attAgility,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
              const Spacer(),
              StatBadgeWrapped(
                label: 'ИНТ',
                info:
                    '${character.intelligence} (${!modifier(character.intelligence).isNegative ? '+' : ''}${modifier(character.intelligence)})',
                color: ColorPalette.attIntelligence,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
              const Spacer(),
              StatBadgeWrapped(
                label: 'ТЕЛ',
                info:
                    '${character.athletics} (${!modifier(character.athletics).isNegative ? '+' : ''}${modifier(character.athletics)})',
                color: ColorPalette.attAthletics,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
              const Spacer(),
              StatBadgeWrapped(
                label: 'ХАР',
                info:
                    '${character.charisma} (${!modifier(character.charisma).isNegative ? '+' : ''}${modifier(character.charisma)})',
                color: ColorPalette.attCharisma,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
              const Spacer(),
              StatBadgeWrapped(
                label: 'МУД',
                info:
                    '${character.wisdom} (${!modifier(character.wisdom).isNegative ? '+' : ''}${modifier(character.wisdom)})',
                color: ColorPalette.attWisdom,
                isEnabled: character.isEnabled,
                textStyle: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
