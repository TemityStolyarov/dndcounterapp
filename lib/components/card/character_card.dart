import 'package:dndcounterapp/components/card/stat_badges/stat_badge.dart';
import 'package:dndcounterapp/components/card/stat_badges/stat_badge_alt.dart';
import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/spell.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterCard extends StatelessWidget {
  final bool colorScheme;
  final Character character;
  final int? index;
  final VoidCallback onClose;
  final Box box;

  const CharacterCard({
    super.key,
    required this.character,
    required this.colorScheme,
    required this.box,
    this.index,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          color: ColorPalette.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme
                  ? ColorPalette.alternativeshadowColor
                  : ColorPalette.shadowColor,
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: onClose,
                      child: const Icon(
                        Icons.close,
                        color: ColorPalette.fontBaseColor,
                      ),
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
                          '${character.kd + _findKD(character.inventory) + _modifier(character.athletics)} AR',
                      color: ColorPalette.attKD,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatBadge(
                      label: 'СИЛ',
                      info:
                          '${character.strength} (${!_modifier(character.strength).isNegative ? '+' : ''}${_modifier(character.strength)})',
                      color: ColorPalette.attStrength,
                    ),
                    const Spacer(),
                    StatBadge(
                      label: 'ЛОВ',
                      info:
                          '${character.agility} (${!_modifier(character.agility).isNegative ? '+' : ''}${_modifier(character.agility)})',
                      color: ColorPalette.attAgility,
                    ),
                    const Spacer(),
                    StatBadge(
                      label: 'ИНТ',
                      info:
                          '${character.intelligence} (${!_modifier(character.intelligence).isNegative ? '+' : ''}${_modifier(character.intelligence)})',
                      color: ColorPalette.attIntelligence,
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
                          '${character.athletics} (${!_modifier(character.athletics).isNegative ? '+' : ''}${_modifier(character.athletics)})',
                      color: ColorPalette.attAthletics,
                    ),
                    const Spacer(),
                    StatBadge(
                      label: 'ХАР',
                      info:
                          '${character.charisma} (${!_modifier(character.charisma).isNegative ? '+' : ''}${_modifier(character.charisma)})',
                      color: ColorPalette.attCharisma,
                    ),
                    const Spacer(),
                    StatBadge(
                      label: 'МУД',
                      info:
                          '${character.wisdom} (${!_modifier(character.wisdom).isNegative ? '+' : ''}${_modifier(character.wisdom)})',
                      color: ColorPalette.attWisdom,
                    ),
                  ],
                ),
              ),
              character.inventory.isEmpty
                  ? Container()
                  : const SizedBox(height: 6),
              character.inventory.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Инвентарь: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(_convertWeaponToText(character.inventory)),
                        ],
                      ),
                    ),
              character.spells.isEmpty
                  ? Container()
                  : const SizedBox(height: 6),
              character.spells.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Книга заклинаний: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(_convertSpellsToText(character.spells)),
                        ],
                      ),
                    ),
              character.description == ''
                  ? Container()
                  : const SizedBox(height: 6),
              character.description == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Описание: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(character.description),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  int _modifier(int attr) {
    if (attr >= 30) return 10;
    if (attr >= 28) return 9;
    if (attr >= 26) return 8;
    if (attr >= 24) return 7;
    if (attr >= 22) return 6;
    if (attr >= 20) return 5;
    if (attr >= 18) return 4;
    if (attr >= 16) return 3;
    if (attr >= 14) return 2;
    if (attr >= 12) return 1;
    if (attr >= 10) return 0;
    if (attr >= 8) return -1;
    if (attr >= 6) return -2;
    if (attr >= 4) return -3;
    if (attr >= 2) {
      return -4;
    } else {
      return -5;
    }
  }

  String _convertWeaponToText(List<Weapon> inventory) {
    List<String> desc = [];
    for (Weapon item in inventory) {
      String itemDesc = '';
      itemDesc += '${item.name}: ';
      if (item.dice != null) itemDesc += '${item.dice}d${item.dmg} урона ';

      if (item.kd != null) {
        itemDesc +=
            'дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите ';
      }

      if (item.description != null && item.description != '') {
        itemDesc += '(${item.description})';
      }
      desc.add(itemDesc);
    }
    return desc.join('\n');
  }

  String _convertSpellsToText(List<Spell> spells) {
    List<String> desc = [];
    for (Spell spell in spells) {
      String itemDesc = '';
      itemDesc += '${spell.name}: ';
      if (spell.dice != null) itemDesc += '${spell.dice}d${spell.dmg} урона ';

      if (spell.description != null && spell.description != '') {
        itemDesc += '(${spell.description})';
      }
      desc.add(itemDesc);
    }
    return desc.join('\n');
  }

  int _findKD(List<Weapon> inventory) {
    int kd = 0;
    for (Weapon item in inventory) {
      if (item.kd != null) kd += item.kd as int;
    }
    return kd;
  }
}
