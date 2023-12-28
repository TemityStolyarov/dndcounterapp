import 'package:dndcounterapp/components/card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/spell.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterCard extends StatefulWidget {
  final bool colorScheme;
  final Character character;
  final int? index;
  final VoidCallback onEdit;
  final VoidCallback onClose;
  final Box box;

  const CharacterCard({
    super.key,
    required this.character,
    required this.colorScheme,
    required this.box,
    this.index,
    required this.onEdit,
    required this.onClose,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isWrapped = true;

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
              color: widget.colorScheme
                  ? ColorPalette.alternativeshadowColor
                  : ColorPalette.shadowColor,
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: isWrapped
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CharacterCardHeader(character: widget.character),
                    const SizedBox(height: 6),
                    CharacterAttrBadges(character: widget.character),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isWrapped = !isWrapped;
                        });
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.more_horiz,
                            color: ColorPalette.fontBaseColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Padding(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: widget.onEdit,
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          InkWell(
                            onTap: widget.onClose,
                            child: const Icon(
                              Icons.delete_forever,
                              size: 22,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CharacterCardHeader(character: widget.character),
                    const SizedBox(height: 6),
                    CharacterAttrBadges(character: widget.character),
                    widget.character.inventory.isEmpty
                        ? Container()
                        : const SizedBox(height: 6),
                    widget.character.inventory.isEmpty
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
                                Text(_convertWeaponToText(
                                    widget.character.inventory)),
                              ],
                            ),
                          ),
                    widget.character.spells.isEmpty
                        ? Container()
                        : const SizedBox(height: 6),
                    widget.character.spells.isEmpty
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
                                Text(_convertSpellsToText(
                                    widget.character.spells)),
                              ],
                            ),
                          ),
                    widget.character.description == ''
                        ? Container()
                        : const SizedBox(height: 6),
                    widget.character.description == ''
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
                                Text(widget.character.description),
                              ],
                            ),
                          ),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isWrapped = !isWrapped;
                        });
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.more_horiz,
                            color: ColorPalette.fontBaseColor,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
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
}
