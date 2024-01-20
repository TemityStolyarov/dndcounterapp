import 'package:dndcounterapp/components/character_card/character_card_window_navigation.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/status_effects/status_effects_row.dart';
import 'package:dndcounterapp/components/character_card/description/character_description.dart';
import 'package:dndcounterapp/components/character_card/spells/spell_list.dart';
import 'package:dndcounterapp/components/character_card/weapons/weapon_list.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UnwrappedCard extends StatelessWidget {
  final Character character;
  final bool isWrapped;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onEdit;
  final VoidCallback onEditItem;
  final VoidCallback onChangeWrap;
  final VoidCallback onInventoryAddModalOpen;
  final VoidCallback onSpellAddModalOpen;
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

  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;

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
    required this.onInventoryAddModalOpen,
    required this.onSpellAddModalOpen,
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
    required this.onEditItem,
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 830,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 14,
          right: 14,
          top: 12,
          bottom: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatacterCardWindowNavigation(
              onEdit: onEdit,
              onChangeWrap: onChangeWrap,
              onClose: onClose,
              isWrapped: isWrapped,
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                SizedBox(
                  width: 374,
                  child: CharacterCardHeader(
                    character: character,
                    onPlus: onPlus,
                    onMinus: onMinus,
                    onReturnDefaultHP: onReturnDefaultHP,
                    onSetHP: onSetHP,
                    onImageUpdate: onImageUpdate,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 374,
                  child: CharacterAttrBadges(
                    character: character,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: ColorPalette.cardColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            CharacterDescription(
              character: character,
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Инвентарь: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 14 / 12,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
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
            CharacterWeaponList(
              inventory: character.inventory,
              charbookBox: charbookBox,
              charbooks: charbooks,
              charbookIndex: charbookIndex,
              characterIndex: index,
              onEditItem: onEditItem,
            ),
            const SizedBox(height: 2),
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
            CharacterSpellList(
              spells: character.spells,
              charbookBox: charbookBox,
              charbooks: charbooks,
              charbookIndex: charbookIndex,
              characterIndex: index,
              onEditItem: onEditItem,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 6,
                bottom: 6,
                left: 80,
                right: 80,
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
    );
  }
}
