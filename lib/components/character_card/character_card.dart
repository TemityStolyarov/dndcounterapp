import 'package:dndcounterapp/components/character_card/unwrapped_card.dart';
import 'package:dndcounterapp/components/character_card/wrapped_card.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
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
  final VoidCallback onEditItem;
  final VoidCallback onClose;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onChangingModifierValue;
  final VoidCallback onInventoryAddModalOpen;
  final VoidCallback onSpellAddModalOpen;
  final VoidCallback onSpellEditModalOpen;
  final VoidCallback onUpdateScreen;

  final VoidCallback onTapStatusKdDebuff;
  final VoidCallback onTapStatusKdBuff;
  final VoidCallback onTapStatusRoped;
  final VoidCallback onTapStatusDmgBuff;
  final VoidCallback onTapStatusFreezed;
  final VoidCallback onTapStatusRollDebuff;
  final VoidCallback onTapStatusRollBuff;
  final VoidCallback onTapStatusProvocated;

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
    required this.onSetHP,
    required this.onImageUpdate,
    required this.onChangingModifierValue,
    required this.onInventoryAddModalOpen,
    required this.onSpellAddModalOpen,
    required this.onSpellEditModalOpen,
    required this.onUpdateScreen,
    required this.onTapStatusKdDebuff,
    required this.onTapStatusKdBuff,
    required this.onTapStatusRoped,
    required this.onTapStatusDmgBuff,
    required this.onTapStatusFreezed,
    required this.onTapStatusRollDebuff,
    required this.onTapStatusRollBuff,
    required this.onTapStatusProvocated, required this.onEditItem,
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
            ? SizedBox(
                width: 400,
                child: WrappedCard(
                  character: widget
                      .charbooks[widget.charbookIndex].chars[widget.index],
                  isWrapped: isWrapped,
                  onPlus: widget.onPlus,
                  onMinus: widget.onMinus,
                  onReturnDefaultHP: widget.onReturnDefaultHP,
                  onSetHP: widget.onSetHP,
                  onImageUpdate: widget.onImageUpdate,
                  onEdit: widget.onEdit,
                  onClose: widget.onClose,
                  onChangeWrap: onChangeWrap,
                  onTapStatusKdDebuff: widget.onTapStatusKdDebuff,
                  onTapStatusKdBuff: widget.onTapStatusKdBuff,
                  onTapStatusRoped: widget.onTapStatusRoped,
                  onTapStatusDmgBuff: widget.onTapStatusDmgBuff,
                  onTapStatusFreezed: widget.onTapStatusFreezed,
                  onTapStatusRollDebuff: widget.onTapStatusRollDebuff,
                  onTapStatusRollBuff: widget.onTapStatusRollBuff,
                  onTapStatusProvocated: widget.onTapStatusProvocated,
                  onClearStatusKdDebuff: _onClearStatusKdDebuff,
                  onClearStatusKdBuff: _onClearStatusKdBuff,
                  onClearStatusRoped: _onClearStatusRoped,
                  onClearStatusDmgBuff: _onClearStatusDmgBuff,
                  onClearStatusFreezed: _onClearStatusFreezed,
                  onClearStatusRollDebuff: _onClearStatusRollDebuff,
                  onClearStatusRollBuff: _onClearStatusRollBuff,
                  onClearStatusProvocated: _onClearStatusProvocated,
                ),
              )
            : UnwrappedCard(
                  charbookBox: widget.charbookBox,
                  charbooks: widget.charbooks,
                  charbookIndex: widget.charbookIndex,
                  index: widget.index,
                  character: widget
                      .charbooks[widget.charbookIndex].chars[widget.index],
                  isWrapped: isWrapped,
                  onPlus: widget.onPlus,
                  onMinus: widget.onMinus,
                  onReturnDefaultHP: widget.onReturnDefaultHP,
                  onSetHP: widget.onSetHP,
                  onImageUpdate: widget.onImageUpdate,
                  onEdit: widget.onEdit,
                  onEditItem: widget.onEditItem,
                  onClose: widget.onClose,
                  onChangeWrap: onChangeWrap,
                  onInventoryAddModalOpen: widget.onInventoryAddModalOpen,
                  onSpellAddModalOpen: widget.onSpellAddModalOpen,
                  onSpellEditModalOpen: widget.onSpellEditModalOpen,
                  inventoryDescription: convertWeaponToText(
                    widget.charbooks[widget.charbookIndex].chars[widget.index]
                        .inventory,
                  ),
                  spellsDescription: convertSpellsToText(
                    spells: widget.charbooks[widget.charbookIndex]
                        .chars[widget.index].spells,
                    index: widget.index,
                    character: widget
                        .charbooks[widget.charbookIndex].chars[widget.index],
                    charbookBox: widget.charbookBox,
                    charbookIndex: widget.charbookIndex,
                    charbooks: widget.charbooks,
                    onUpdateScreen: widget.onUpdateScreen,
                  ),
                  onTapStatusKdDebuff: widget.onTapStatusKdDebuff,
                  onTapStatusKdBuff: widget.onTapStatusKdBuff,
                  onTapStatusRoped: widget.onTapStatusRoped,
                  onTapStatusDmgBuff: widget.onTapStatusDmgBuff,
                  onTapStatusFreezed: widget.onTapStatusFreezed,
                  onTapStatusRollDebuff: widget.onTapStatusRollDebuff,
                  onTapStatusRollBuff: widget.onTapStatusRollBuff,
                  onTapStatusProvocated: widget.onTapStatusProvocated,
                  onClearStatusKdDebuff: _onClearStatusKdDebuff,
                  onClearStatusKdBuff: _onClearStatusKdBuff,
                  onClearStatusRoped: _onClearStatusRoped,
                  onClearStatusDmgBuff: _onClearStatusDmgBuff,
                  onClearStatusFreezed: _onClearStatusFreezed,
                  onClearStatusRollDebuff: _onClearStatusRollDebuff,
                  onClearStatusRollBuff: _onClearStatusRollBuff,
                  onClearStatusProvocated: _onClearStatusProvocated,
                ),
      ),
    );
  }

  void onChangeWrap() {
    setState(() {
      isWrapped = !isWrapped;
    });
  }

  _onClearStatusKdDebuff() {
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    final kdDebuff = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusKdDebuff;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusKdDebuff: kdDebuff!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusKdBuff() {
    final kdBuff =
        widget.charbooks[widget.charbookIndex].chars[widget.index].statusKdBuff;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusKdBuff: kdBuff!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusRoped() {
    final roped =
        widget.charbooks[widget.charbookIndex].chars[widget.index].statusRoped;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusRoped: roped!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusDmgBuff() {
    final dmgBuff = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusDmgBuff;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusDmgBuff: dmgBuff!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusFreezed() {
    final freezed = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusFreezed;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusFreezed: freezed!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusRollDebuff() {
    final rollDebuff = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusRollDebuff;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusRollDebuff: rollDebuff!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusRollBuff() {
    final rollBuff = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusRollBuff;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusRollBuff: rollBuff!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }

  _onClearStatusProvocated() {
    final provocated = widget
        .charbooks[widget.charbookIndex].chars[widget.index].statusProvocated;
    List<Character> charList = widget.charbooks[widget.charbookIndex].chars;
    charList[widget.index] = widget
        .charbooks[widget.charbookIndex].chars[widget.index]
        .copyWith(statusProvocated: provocated!.isEmpty ? 'Вкл' : '');

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }
}
