import 'package:dndcounterapp/components/card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_wrapped_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/components/card/character_modal/inventory_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/inventory_edit_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/spell_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/spell_edit_modal.dart';
import 'package:dndcounterapp/core/helpers.dart';
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
  final VoidCallback onEditItem;
  final VoidCallback onDeleteItem;
  final VoidCallback onEditSpell;
  final VoidCallback onDeleteSpell;
  final VoidCallback onChangingModifierValue;

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
    required this.onEditItem,
    required this.onDeleteItem,
    required this.onEditSpell,
    required this.onDeleteSpell,
    required this.onChangingModifierValue,
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
        width: 380,
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
                    isWrapped
                        ? CharacterCardWrappedHeader(
                            character: widget.character,
                            onPlus: widget.onPlus,
                            onMinus: widget.onMinus,
                            onReturnDefaultHP: widget.onReturnDefaultHP,
                            onImageUpdate: widget.onImageUpdate,
                          )
                        : CharacterCardHeader(
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
                                onEditItem: widget.onEditItem,
                                onDeleteItem: widget.onDeleteItem,
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
                                onEditSpell: widget.onEditSpell,
                                onDeleteSpell: widget.onDeleteSpell,
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
                                spells: widget.character.spells,
                                box: widget.box,
                                index: widget.index,
                                character: widget.character,
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
        itemDesc += '${item.dice}d${item.dmg} урона';
      }

      if (item.kd != null && item.dice == null) {
        itemDesc +=
            'Дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите';
      }

      if (item.dice != null && item.kd != null) {
        itemDesc +=
            '${item.dice}d${item.dmg} урона, дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите';
      }

      if ((item.dice != null && item.dmg != null) &&
          item.description != null &&
          item.description != '') {
        itemDesc += ' (${item.description})';
      }

      if ((item.dice == null && item.dmg == null) &&
          item.description != null &&
          item.description != '') {
        itemDesc += uppercaseFirst(item.description);
      }

      desc.add(
        Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      );
      if (itemDesc.isNotEmpty) {
        desc.add(Text(itemDesc));
      }
      desc.add(const SizedBox(height: 8));
    }
    return desc;
  }

  List<Widget> _convertSpellsToText({
    required List<Spell> spells,
    required Box box,
    required int index,
    required Character character,
  }) {
    List<Widget> desc = [];
    for (int i = 0; i < spells.length; i++) {
      String spellDesc = '';
      if (spells[i].dice != null && spells[i].dmg != null) {
        spellDesc += '${spells[i].dice}d${spells[i].dmg} урона';
      }

      if (spells[i].dice != null &&
          spells[i].dmg != null &&
          spells[i].energyOnCast != null &&
          spells[i].energyDescription != null) {
        spellDesc +=
            ', при применении -${spells[i].energyOnCast} ${spells[i].energyDescription}';
      }

      if (spells[i].dice == null &&
          spells[i].dmg == null &&
          spells[i].energyOnCast != null &&
          spells[i].energyDescription != null) {
        spellDesc +=
            'При применении -${spells[i].energyOnCast} ${spells[i].energyDescription}';
      }

      if (((spells[i].dice != null && spells[i].dmg != null) ||
              (spells[i].energyOnCast != null &&
                  spells[i].energyDescription != null)) &&
          spells[i].description != null &&
          spells[i].description != '') {
        spellDesc += ' (${spells[i].description})';
      }

      if ((spells[i].dice == null &&
              spells[i].dmg == null &&
              spells[i].energyOnCast == null &&
              spells[i].energyDescription == null) &&
          spells[i].description != null &&
          spells[i].description != '') {
        spellDesc += '${spells[i].description}';
      }

      if (spells[i].cast != null && spells[i].castModifier != null) {
        desc.add(
          Row(
            children: [
              Text(
                '${spells[i].name} (${spells[i].cast! + spells[i].castModifier!}/${spells[i].cast})',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              MiniButton(
                icon: Icons.add,
                onTap: () {
                  Spell spell = spells[i];
                  List<Spell> newSpellList = spells;
                  int newCastModifier = spells[i].castModifier! + 1;

                  newSpellList[i] =
                      spell.copyWith(castModifier: newCastModifier);
                  final changedCharacter = character.copyWith(
                    spells: newSpellList,
                  );
                  box.putAt(index, changedCharacter);
                  _updateScreen();
                },
              ),
              const SizedBox(width: 4),
              MiniButton(
                icon: Icons.remove,
                onTap: () {
                  Spell spell = spells[i];
                  List<Spell> newSpellList = spells;
                  int newCastModifier = spells[i].castModifier! - 1;

                  newSpellList[i] =
                      spell.copyWith(castModifier: newCastModifier);
                  final changedCharacter = character.copyWith(
                    spells: newSpellList,
                  );
                  box.putAt(index, changedCharacter);
                  _updateScreen();
                },
              ),
            ],
          ),
        );
      } else {
        desc.add(
          Text(
            spells[i].name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      }
      if (spellDesc.isNotEmpty) {
        desc.add(Text(spellDesc));
      }
      desc.add(const SizedBox(height: 8));
    }
    return desc;
  }

  void _updateScreen() {
    widget.onChangingModifierValue();
    print('Modifier value changed!');
  }
}
