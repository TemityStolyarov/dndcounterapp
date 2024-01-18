import 'package:dndcounterapp/components/character_card/character_card_window_navigation.dart';
import 'package:dndcounterapp/components/character_card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/character_card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/character_card/character_description_blocks/stat_badges/status_effects_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class UnwrappedCard extends StatelessWidget {
  final Character character;
  final bool isWrapped;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onEdit;
  final VoidCallback onChangeWrap;
  final VoidCallback onInventoryEditModalOpen;
  final VoidCallback onInventoryAddModalOpen;
  final List<Widget> inventoryDescription;
  final VoidCallback onSpellEditModalOpen;
  final VoidCallback onSpellAddModalOpen;
  final List<Widget> spellsDescription;
  final VoidCallback onClose;

  final VoidCallback onTapStatusKdDebuff;
  final VoidCallback onTapStatusKdBuff;
  final VoidCallback onTapStatusRoped;
  final VoidCallback onTapStatusDmgBuff;
  final VoidCallback onTapStatusFreezed;
  final VoidCallback onTapStatusRollDebuff;
  final VoidCallback onTapStatusRollBuff;
  final VoidCallback onTapStatusProvocated;

  final VoidCallback onClearStatusKdDebuff;
  final VoidCallback onClearStatusKdBuff;
  final VoidCallback onClearStatusRoped;
  final VoidCallback onClearStatusDmgBuff;
  final VoidCallback onClearStatusFreezed;
  final VoidCallback onClearStatusRollDebuff;
  final VoidCallback onClearStatusRollBuff;
  final VoidCallback onClearStatusProvocated;

  const UnwrappedCard({
    super.key,
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onSetHP,
    required this.onImageUpdate,
    required this.onEdit,
    required this.onChangeWrap,
    required this.onInventoryEditModalOpen,
    required this.onInventoryAddModalOpen,
    required this.inventoryDescription,
    required this.onSpellEditModalOpen,
    required this.onSpellAddModalOpen,
    required this.spellsDescription,
    required this.onClose,
    required this.onTapStatusKdDebuff,
    required this.onTapStatusKdBuff,
    required this.onTapStatusRoped,
    required this.onTapStatusDmgBuff,
    required this.onTapStatusFreezed,
    required this.onTapStatusRollDebuff,
    required this.onTapStatusRollBuff,
    required this.onTapStatusProvocated,
    required this.onClearStatusKdDebuff,
    required this.onClearStatusKdBuff,
    required this.onClearStatusRoped,
    required this.onClearStatusDmgBuff,
    required this.onClearStatusFreezed,
    required this.onClearStatusRollDebuff,
    required this.onClearStatusRollBuff,
    required this.onClearStatusProvocated,
    required this.isWrapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        right: 14,
        top: 12,
        bottom: 14,
      ),
      child: Column(
        children: [
          ChatacterCardWindowNavigation(
            onEdit: onEdit,
            onChangeWrap: onChangeWrap,
            onClose: onClose,
            isWrapped: isWrapped,
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 380,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CharacterCardHeader(
                      character: character,
                      onPlus: onPlus,
                      onMinus: onMinus,
                      onReturnDefaultHP: onReturnDefaultHP,
                      onSetHP: onSetHP,
                      onImageUpdate: onImageUpdate,
                    ),
                    const SizedBox(height: 4),
                    CharacterAttrBadges(
                      character: character,
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
                            onTap: onInventoryEditModalOpen,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: onInventoryAddModalOpen,
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          ),
                        ],
                      ),
                    ),
                    character.inventory.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: inventoryDescription,
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 380,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    character.description == ''
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
                                Text(character.description),
                              ],
                            ),
                          ),
                    const SizedBox(height: 4),
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
                            onTap: onSpellEditModalOpen,
                            child: const Icon(
                              Icons.edit,
                              size: 16,
                              color: ColorPalette.attKD,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: onSpellAddModalOpen,
                            child: const Icon(
                              Icons.add_box_outlined,
                              size: 18,
                              color: ColorPalette.attKD,
                            ),
                          )
                        ],
                      ),
                    ),
                    character.spells.isEmpty
                        ? const SizedBox.shrink()
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: spellsDescription,
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 12,
                      ),
                      child: StatusEffectsRow(
                        alignment: StatusEffectsRowAlignment.spaceBetween,
                        character: character,
                        onTapStatusKdDebuff: onTapStatusKdDebuff,
                        onTapStatusKdBuff: onTapStatusKdBuff,
                        onTapStatusRoped: onTapStatusRoped,
                        onTapStatusDmgBuff: onTapStatusDmgBuff,
                        onTapStatusFreezed: onTapStatusFreezed,
                        onTapStatusProvocated: onTapStatusProvocated,
                        onTapStatusRollBuff: onTapStatusRollBuff,
                        onTapStatusRollDebuff: onTapStatusRollDebuff,
                        onClearStatusKdDebuff: onClearStatusKdDebuff,
                        onClearStatusKdBuff: onClearStatusKdBuff,
                        onClearStatusRoped: onClearStatusRoped,
                        onClearStatusDmgBuff: onClearStatusDmgBuff,
                        onClearStatusFreezed: onClearStatusFreezed,
                        onClearStatusProvocated: onClearStatusProvocated,
                        onClearStatusRollBuff: onClearStatusRollBuff,
                        onClearStatusRollDebuff: onClearStatusRollDebuff,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
