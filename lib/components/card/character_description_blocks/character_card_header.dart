import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_alt.dart';
import 'package:dndcounterapp/components/helpers.dart';
import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterCardHeader extends StatelessWidget {
  final Character character;

  const CharacterCardHeader({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatBadgeAlt(
            info: '${character.hp} HP',
            color: ColorPalette.attHP,
          ),
          Column(
            children: [
              SizedBox(
                width: 200,
                child: Text(
                  character.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  '${character.race} • ${character.crClass}',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          StatBadgeAlt(
            info:
                '${character.kd + _findKD(character.inventory) + modifier(character.athletics)} AR',
            color: ColorPalette.attKD,
          ),
        ],
      ),
    );
  }

  int _findKD(List<Weapon> inventory) {
    int kd = 0;
    for (Weapon item in inventory) {
      if (item.kd != null) kd += item.kd as int;
    }
    return kd;
  }
}
