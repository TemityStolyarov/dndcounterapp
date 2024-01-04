import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterAttrBadges extends StatelessWidget {
  final Character character;

  const CharacterAttrBadges({super.key, required this.character});

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
              StatBadge(
                label: 'СИЛ',
                info:
                    '${character.strength} (${!modifier(character.strength).isNegative ? '+' : ''}${modifier(character.strength)})',
                color: ColorPalette.attStrength,
                isEnabled: character.isEnabled,
              ),
              const Spacer(),
              StatBadge(
                label: 'ЛОВ',
                info:
                    '${character.agility} (${!modifier(character.agility).isNegative ? '+' : ''}${modifier(character.agility)})',
                color: ColorPalette.attAgility,
                isEnabled: character.isEnabled,
              ),
              const Spacer(),
              StatBadge(
                label: 'ИНТ',
                info:
                    '${character.intelligence} (${!modifier(character.intelligence).isNegative ? '+' : ''}${modifier(character.intelligence)})',
                color: ColorPalette.attIntelligence,
                isEnabled: character.isEnabled,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatBadge(
                label: 'ТЕЛ',
                info:
                    '${character.athletics} (${!modifier(character.athletics).isNegative ? '+' : ''}${modifier(character.athletics)})',
                color: ColorPalette.attAthletics,
                isEnabled: character.isEnabled,
              ),
              const Spacer(),
              StatBadge(
                label: 'ХАР',
                info:
                    '${character.charisma} (${!modifier(character.charisma).isNegative ? '+' : ''}${modifier(character.charisma)})',
                color: ColorPalette.attCharisma,
                isEnabled: character.isEnabled,
              ),
              const Spacer(),
              StatBadge(
                label: 'МУД',
                info:
                    '${character.wisdom} (${!modifier(character.wisdom).isNegative ? '+' : ''}${modifier(character.wisdom)})',
                color: ColorPalette.attWisdom,
                isEnabled: character.isEnabled,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
