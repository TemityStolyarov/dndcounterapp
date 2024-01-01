import 'package:dndcounterapp/components/card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/card/character_modal/inventory_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/inventory_edit_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/spell_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/spell_edit_modal.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterCard extends StatefulWidget {
  final bool colorScheme;
  final Character character;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onClose;
  final Box box;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onAddItem;
  final VoidCallback onAddSpell;
  final VoidCallback onImageUpdate;

  const CharacterCard({
    super.key,
    required this.character,
    required this.colorScheme,
    required this.box,
    required this.index,
    required this.onEdit,
    required this.onClose,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onAddItem,
    required this.onAddSpell,
    required this.onImageUpdate,
  });

  @override
  State<CharacterCard> createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isWrapped = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 380, //340
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
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CharacterCardHeader(
                      character: widget.character,
                      onPlus: widget.onPlus,
                      onMinus: widget.onMinus,
                      onReturnDefaultHP: widget.onReturnDefaultHP,
                      onImageUpdate: widget.onImageUpdate,
                    ),
                    const SizedBox(height: 4),
                    CharacterAttrBadges(character: widget.character),
                    const SizedBox(height: 6),
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
                  top: 16,
                  left: 16,
                  right: 16,
                  bottom: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CharacterCardHeader(
                      character: widget.character,
                      onPlus: widget.onPlus,
                      onMinus: widget.onMinus,
                      onReturnDefaultHP: widget.onReturnDefaultHP,
                      onImageUpdate: widget.onImageUpdate,
                    ),
                    const SizedBox(height: 4),
                    CharacterAttrBadges(character: widget.character),
                    const SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Инвентарь: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              final inventoryEditModal = InventoryEditModal(
                                box: widget.box,
                                index: widget.index,
                                onEdit: () {}, // TODO
                                onDelete: () {}, // TODO
                              );
                              inventoryEditModal.show(context);
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              final inventoryAddModal = InventoryAddModal(
                                box: widget.box,
                                index: widget.index,
                                onAddItem: widget.onAddItem,
                              );
                              inventoryAddModal.show(context);
                            },
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.character.inventory.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _convertWeaponToText(
                                widget.character.inventory,
                              ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Книга заклинаний: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              final spellEditModal = SpellEditModal(
                                box: widget.box,
                                index: widget.index,
                                onEdit: () {}, // TODO implement spell editing
                                onDelete:
                                    () {}, // TODO implement spell deleting
                              );
                              spellEditModal.show(context);
                            },
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              final spellAddModal = SpellAddModal(
                                box: widget.box,
                                index: widget.index,
                                onAddSpell: widget.onAddItem,
                              );
                              spellAddModal.show(context);
                            },
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.character.spells.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _convertSpellsToText(
                                widget.character.spells,
                              ),
                            ),
                          ),
                    widget.character.description == ''
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Описание: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(widget.character.description),
                              ],
                            ),
                          ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: InkWell(
                            onTap: widget.onEdit,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isWrapped = !isWrapped;
                            });
                          },
                          child: const Center(
                            child: Icon(
                              Icons.more_horiz,
                              color: ColorPalette.fontBaseColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: widget.onClose,
                          child: const Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: ColorPalette.attKD,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }

  List<Widget> _convertWeaponToText(List<Weapon> inventory) {
    List<Widget> desc = [];
    for (Weapon item in inventory) {
      String itemDesc = '';
      if (item.dice != null && item.kd == null) {
        itemDesc += '${item.dice}d${item.dmg} урона ';
      }

      if (item.kd != null && item.dice == null) {
        itemDesc +=
            'дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите ';
      }

      if (item.dice != null && item.kd != null) {
        itemDesc +=
            '${item.dice}d${item.dmg} урона, дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите ';
      }

      if (item.description != null && item.description != '') {
        itemDesc += '(${item.description})';
      }
      desc.add(
        Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      );
      desc.add(Text(itemDesc));
      desc.add(const SizedBox(height: 8));
    }
    return desc;
  }

  List<Widget> _convertSpellsToText(List<Spell> spells) {
    List<Widget> desc = [];
    for (Spell spell in spells) {
      String itemDesc = '';
      if (spell.dice != null && spell.dmg != null)
        itemDesc += '${spell.dice}d${spell.dmg} урона';

      if (spell.dice != null &&
          spell.dmg != null &&
          spell.energyOnCast != null &&
          spell.energyDescription != null) {
        itemDesc +=
            ', при применении -${spell.energyOnCast} ${spell.energyDescription}';
      }

      if (spell.dice == null &&
          spell.dmg == null &&
          spell.energyOnCast != null &&
          spell.energyDescription != null) {
        itemDesc +=
            'При применении -${spell.energyOnCast} ${spell.energyDescription}';
      }

      if (((spell.dice != null && spell.dmg != null) ||
              (spell.energyOnCast != null &&
                  spell.energyDescription != null)) &&
          spell.description != null &&
          spell.description != '') {
        itemDesc += ' (${spell.description})';
      }

      if ((spell.dice == null &&
              spell.dmg == null &&
              spell.energyOnCast == null &&
              spell.energyDescription == null) &&
          spell.description != null &&
          spell.description != '') {
        itemDesc += '${spell.description}';
      }

      if (spell.cast != null && spell.castModifier != null) {
        desc.add(
          Text(
            '${spell.name} (${spell.cast! + spell.castModifier!}/${spell.cast})',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      } else {
        desc.add(
          Text(
            spell.name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      }
      desc.add(Text(itemDesc));
      desc.add(const SizedBox(height: 8));
    }
    return desc;
  }
}
