import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_alt.dart';
import 'package:dndcounterapp/components/helpers.dart';
import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterCardHeader extends StatelessWidget {
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final Character character;

  const CharacterCardHeader({
    super.key,
    required this.character,
    required this.onPlus,
    required this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.network(
                character.imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.cubeRolling.withOpacity(0.2),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              SizedBox(
                width: 190,
                child: Text(
                  character.name,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 190,
                child: Text(
                  '${character.race} • ${character.crClass}',
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  MiniButton(
                    icon: Icons.add,
                    onTap: onPlus,
                  ),
                  const SizedBox(width: 4),
                  MiniButton(
                    icon: Icons.remove,
                    onTap: onMinus,
                  ),
                  const SizedBox(width: 8),
                  StatBadgeAlt(
                    info:
                        '${character.hp + character.hpModifier}/${character.hp} HP',
                    color: ColorPalette.attHP,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              StatBadgeAlt(
                info:
                    '${character.kd + _findKD(character.inventory) + modifier(character.athletics)} AR',
                color: ColorPalette.attKD,
              ),
            ],
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
