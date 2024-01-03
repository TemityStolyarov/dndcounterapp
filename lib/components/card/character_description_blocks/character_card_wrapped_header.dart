import 'dart:ui';

import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_ar.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/stat_badge_hp.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class CharacterCardWrappedHeader extends StatelessWidget {
  final Character character;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onImageUpdate;

  const CharacterCardWrappedHeader({
    super.key,
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onImageUpdate,
  });

  @override
  Widget build(BuildContext context) {
    const double textFieldsWidth = 160;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onImageUpdate,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: GestureDetector(
                onTap: onImageUpdate,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(
                      character.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorPalette.cubeRolling.withOpacity(0.2),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: textFieldsWidth,
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
                  const SizedBox(height: 4),
                  SizedBox(
                    width: textFieldsWidth,
                    child: Text(
                      '${character.race} • ${character.crClass}',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      MiniButton(
                        icon: Icons.add,
                        onTap: onPlus,
                      ),
                      const SizedBox(width: 6),
                      StatBadgeHP(
                        hp: character.hp,
                        hpModifier: character.hpModifier,
                        info: '${character.hp + character.hpModifier} HP',
                        onReturnDefaultHP: onReturnDefaultHP,
                        color:
                            character.hp > (character.hp + character.hpModifier)
                                ? ColorPalette.critUnlucky
                                : character.hp <
                                        (character.hp + character.hpModifier)
                                    ? ColorPalette.attHP
                                    : ColorPalette.attHP,
                      ),
                      const SizedBox(width: 6),
                      MiniButton(
                        icon: Icons.remove,
                        onTap: onMinus,
                      ),
                      const SizedBox(width: 24),
                      StatBadgeAR(
                        info:
                            '${character.kd + _findKD(character.inventory) + modifier(character.athletics)} AR',
                        color: ColorPalette.attKD,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
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
