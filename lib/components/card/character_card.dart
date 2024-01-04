import 'package:dndcounterapp/components/card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_wrapped_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterCard extends StatefulWidget {
  final bool colorScheme;
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;

  final VoidCallback onEdit;
  final VoidCallback onClose;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onChangingModifierValue;
  final VoidCallback onInventoryAddModalOpen;
  final VoidCallback onInventoryEditModalOpen;
  final VoidCallback onSpellAddModalOpen;
  final VoidCallback onSpellEditModalOpen;
  final VoidCallback onUpdateScreen;

  const CharacterCard({
    super.key,
    required this.colorScheme,
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onEdit,
    required this.onClose,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onImageUpdate,
    required this.onChangingModifierValue,
    required this.onInventoryAddModalOpen,
    required this.onInventoryEditModalOpen,
    required this.onSpellAddModalOpen,
    required this.onSpellEditModalOpen,
    required this.onUpdateScreen,
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
          color: widget
                  .charbooks[widget.charbookIndex].chars[widget.index].isEnabled
              ? ColorPalette.cardColor
              : ColorPalette.disabledBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: widget
                  .charbooks[widget.charbookIndex].chars[widget.index].isEnabled
              ? [
                  BoxShadow(
                    color: widget.colorScheme
                        ? ColorPalette.alternativeshadowColor
                        : ColorPalette.shadowColor,
                    offset: const Offset(0, 5),
                    blurRadius: 10,
                    spreadRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: widget.colorScheme
                        ? ColorPalette.alternativeshadowColor.withOpacity(0.1)
                        : ColorPalette.shadowColor.withOpacity(0.1),
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
                  bottom: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    isWrapped
                        ? CharacterCardWrappedHeader(
                            character: widget.charbooks[widget.charbookIndex]
                                .chars[widget.index],
                            onPlus: widget.onPlus,
                            onMinus: widget.onMinus,
                            onReturnDefaultHP: widget.onReturnDefaultHP,
                            onImageUpdate: widget.onImageUpdate,
                          )
                        : CharacterCardHeader(
                            character: widget.charbooks[widget.charbookIndex]
                                .chars[widget.index],
                            onPlus: widget.onPlus,
                            onMinus: widget.onMinus,
                            onReturnDefaultHP: widget.onReturnDefaultHP,
                            onImageUpdate: widget.onImageUpdate,
                          ),
                    const SizedBox(height: 4),
                    CharacterAttrBadges(
                      character: widget
                          .charbooks[widget.charbookIndex].chars[widget.index],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: InkWell(
                            onTap: widget.onEdit,
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD.withOpacity(0.4),
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
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(width: 18),
                        ),
                      ],
                    ),
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
                      character: widget
                          .charbooks[widget.charbookIndex].chars[widget.index],
                      onPlus: widget.onPlus,
                      onMinus: widget.onMinus,
                      onReturnDefaultHP: widget.onReturnDefaultHP,
                      onImageUpdate: widget.onImageUpdate,
                    ),
                    const SizedBox(height: 4),
                    CharacterAttrBadges(
                      character: widget
                          .charbooks[widget.charbookIndex].chars[widget.index],
                    ),
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
                            onTap: widget.onInventoryEditModalOpen,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: widget.onInventoryAddModalOpen,
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ],
                      ),
                    ),
                    widget.charbooks[widget.charbookIndex].chars[widget.index]
                            .inventory.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _convertWeaponToText(
                                widget.charbooks[widget.charbookIndex]
                                    .chars[widget.index].inventory,
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
                            onTap: widget.onSpellEditModalOpen,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: widget.onSpellAddModalOpen,
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          )
                        ],
                      ),
                    ),
                    widget.charbooks[widget.charbookIndex].chars[widget.index]
                            .spells.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _convertSpellsToText(
                                spells: widget.charbooks[widget.charbookIndex]
                                    .chars[widget.index].spells,
                                index: widget.index,
                                character: widget
                                    .charbooks[widget.charbookIndex]
                                    .chars[widget.index],
                              ),
                            ),
                          ),
                    widget.charbooks[widget.charbookIndex].chars[widget.index]
                                .description ==
                            ''
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
                                Text(widget.charbooks[widget.charbookIndex]
                                    .chars[widget.index].description),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: InkWell(
                            onTap: widget.onClose,
                            child: const Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ),
                      ],
                    ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: MiniButton(
                  icon: Icons.remove,
                  onTap: () {
                    Spell spell = spells[i];
                    List<Character> charList =
                        widget.charbooks[widget.charbookIndex].chars;
                    charList[index].spells[i] = spell.copyWith(
                        castModifier: spells[i].castModifier! - 1);
                    final CharBook updatedCharbook = widget
                        .charbooks[widget.charbookIndex]
                        .copyWith(chars: charList);
                    widget.charbookBox
                        .putAt(widget.charbookIndex, updatedCharbook);
                    widget.onUpdateScreen();
                  },
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: MiniButton(
                  icon: Icons.add,
                  onTap: () {
                    Spell spell = spells[i];
                    List<Character> charList =
                        widget.charbooks[widget.charbookIndex].chars;
                    charList[index].spells[i] = spell.copyWith(
                        castModifier: spells[i].castModifier! + 1);
                    final CharBook updatedCharbook = widget
                        .charbooks[widget.charbookIndex]
                        .copyWith(chars: charList);
                    widget.charbookBox
                        .putAt(widget.charbookIndex, updatedCharbook);
                    widget.onUpdateScreen();
                  },
                ),
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
