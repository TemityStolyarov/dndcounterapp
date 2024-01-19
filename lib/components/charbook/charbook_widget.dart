import 'package:dndcounterapp/components/character_card/character_card.dart';
import 'package:dndcounterapp/components/character_card/character_card_add.dart';
import 'package:dndcounterapp/components/character_card/character_modal/character_add_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/character_edit_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/image_update_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/inventory_add_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/set_hp_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/spell_add_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/spell_edit_modal.dart';
import 'package:dndcounterapp/components/character_card/character_modal/status_effect_modal.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharbookWidget extends StatelessWidget {
  final List<CharBook> charbooks;
  final Box charbookBox;
  final int charbookIndex;
  final bool colorScheme;
  final VoidCallback onUpdateScreen;

  const CharbookWidget({
    super.key,
    required this.charbooks,
    required this.charbookBox,
    required this.charbookIndex,
    required this.colorScheme,
    required this.onUpdateScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        for (int index = 0;
            index < charbooks[charbookIndex].chars.length;
            index++)
          CharacterCard(
            colorScheme: colorScheme,
            charbookBox: charbookBox,
            charbooks: charbooks,
            charbookIndex: charbookIndex,
            index: index,
            onUpdateScreen: onUpdateScreen,
            onChangingModifierValue: onUpdateScreen,
            onEditItem: onUpdateScreen,
            onTapStatusKdDebuff: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusKdDebuff,
                statusEffectLabel: 'Пробитие КД (количество)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusKdBuff: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusKdBuff,
                statusEffectLabel: 'Бонус к КД (количество)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusRoped: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusRoped,
                statusEffectLabel: 'Связан (количество ходов)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusDmgBuff: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusDmgBuff,
                statusEffectLabel: 'Бонусный урон (количество)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusFreezed: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusFreezed,
                statusEffectLabel: 'Пропуск хода (количество ходов)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusRollDebuff: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusRollDebuff,
                statusEffectLabel: 'Броски с помехой (количество ходов)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusRollBuff: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusRollBuff,
                statusEffectLabel: 'Броски с преимуществом (количество ходов)',
              );
              statusEffectModal.show(context);
            },
            onTapStatusProvocated: () {
              final statusEffectModal = StatusEffectModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEdit: onUpdateScreen,
                statusEffectName: StatusEffect.statusProvocated,
                statusEffectLabel: 'Провокация',
              );
              statusEffectModal.show(context);
            },
            onClose: () {
              List<Character> charList = charbooks[charbookIndex].chars;
              charList.removeAt(index);
              final CharBook updatedCharbook =
                  charbooks[charbookIndex].copyWith(chars: charList);
              charbookBox.putAt(charbookIndex, updatedCharbook);
              onUpdateScreen();
            },
            onEdit: () {
              final characterEditModal = CharacterEditModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onSave: onUpdateScreen,
              );
              characterEditModal.show(context);
            },
            onPlus: () {
              List<Character> charList = charbooks[charbookIndex].chars;
              charList[index] = charList[index].copyWith(
                hpModifier:
                    charbooks[charbookIndex].chars[index].hpModifier + 1,
              );
              final CharBook updatedCharbook =
                  charbooks[charbookIndex].copyWith(
                chars: charList,
              );
              charbookBox.putAt(charbookIndex, updatedCharbook);
              onUpdateScreen();
            },
            onMinus: () {
              List<Character> charList = charbooks[charbookIndex].chars;
              charList[index] = charList[index].copyWith(
                hpModifier:
                    charbooks[charbookIndex].chars[index].hpModifier - 1,
              );
              final CharBook updatedCharbook =
                  charbooks[charbookIndex].copyWith(
                chars: charList,
              );
              charbookBox.putAt(charbookIndex, updatedCharbook);
              onUpdateScreen();
            },
            onReturnDefaultHP: () {
              List<Character> charList = charbooks[charbookIndex].chars;
              charList[index] = charList[index].copyWith(
                hpModifier: 0,
              );
              final CharBook updatedCharbook =
                  charbooks[charbookIndex].copyWith(
                chars: charList,
              );
              charbookBox.putAt(charbookIndex, updatedCharbook);
              onUpdateScreen();
            },
            onSetHP: () {
              final setHpModal = SetHPModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onSetHP: onUpdateScreen,
              );
              setHpModal.show(context);
            },
            onImageUpdate: () {
              final imageUpdateModal = ImageUpdateModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onImageUpdate: onUpdateScreen,
              );
              imageUpdateModal.show(context);
            },
            onInventoryAddModalOpen: () {
              final inventoryAddModal = InventoryAddModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onAddItem: onUpdateScreen,
              );
              inventoryAddModal.show(context);
            },
            // onInventoryEditModalOpen: () {
            //   final inventoryEditModal = InventoryEditModal(
            //     charbookBox: charbookBox,
            //     charbooks: charbooks,
            //     charbookIndex: charbookIndex,
            //     index: index,
            //     onEditItem: onUpdateScreen,
            //     onDeleteItem: onUpdateScreen,
            //   );
            //   inventoryEditModal.show(context);
            // },
            onSpellAddModalOpen: () {
              final spellAddModal = SpellAddModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onAddSpell: onUpdateScreen,
              );
              spellAddModal.show(context);
            },
            onSpellEditModalOpen: () {
              final spellEditModal = SpellEditModal(
                charbookBox: charbookBox,
                charbooks: charbooks,
                charbookIndex: charbookIndex,
                index: index,
                onEditSpell: onUpdateScreen,
                onDeleteSpell: onUpdateScreen,
              );
              spellEditModal.show(context);
            },
          ),
        CharacterCardAdd(
          colorScheme: colorScheme,
          onAdd: () {
            final characterAddModal = CharacterAddModal(
              charbookBox: charbookBox,
              charbooks: charbooks,
              charbookIndex: charbookIndex,
              onAdd: onUpdateScreen,
            );
            characterAddModal.show(context);
          },
        ),
      ],
    );
  }
}
