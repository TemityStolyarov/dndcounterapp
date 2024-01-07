import 'package:dndcounterapp/components/card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_card_wrapped_header.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/stat_badges/status_effects_row.dart';
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
  final VoidCallback onTapStatusKdDebuff;
  final VoidCallback onTapStatusKdBuff;
  final VoidCallback onTapStatusRoped;
  final VoidCallback onTapStatusDmgBuff;
  final VoidCallback onTapStatusFreezed;

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
    required this.onTapStatusKdDebuff,
    required this.onTapStatusKdBuff,
    required this.onTapStatusRoped,
    required this.onTapStatusDmgBuff,
    required this.onTapStatusFreezed,
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
                width: 389,
                child: _WrappedCard(
                  character: widget
                      .charbooks[widget.charbookIndex].chars[widget.index],
                  onPlus: widget.onPlus,
                  onMinus: widget.onMinus,
                  onReturnDefaultHP: widget.onReturnDefaultHP,
                  onImageUpdate: widget.onImageUpdate,
                  onEdit: widget.onEdit,
                  onChangeWrap: onChangeWrap,
                  onTapStatusKdDebuff: widget.onTapStatusKdDebuff,
                  onTapStatusKdBuff: widget.onTapStatusKdBuff,
                  onTapStatusRoped: widget.onTapStatusRoped,
                  onTapStatusDmgBuff: widget.onTapStatusDmgBuff,
                  onTapStatusFreezed: widget.onTapStatusFreezed,
                  onClearStatusKdDebuff: _onClearStatusKdDebuff,
                  onClearStatusKdBuff: _onClearStatusKdBuff,
                  onClearStatusRoped: _onClearStatusRoped,
                  onClearStatusDmgBuff: _onClearStatusDmgBuff,
                  onClearStatusFreezed: _onClearStatusFreezed,
                ),
              )
            : SizedBox(
                width: 810,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  child: _UnweappedCard(
                    character: widget
                        .charbooks[widget.charbookIndex].chars[widget.index],
                    onPlus: widget.onPlus,
                    onMinus: widget.onMinus,
                    onReturnDefaultHP: widget.onReturnDefaultHP,
                    onImageUpdate: widget.onImageUpdate,
                    onEdit: widget.onEdit,
                    onChangeWrap: onChangeWrap,
                    onInventoryAddModalOpen: widget.onInventoryAddModalOpen,
                    onInventoryEditModalOpen: widget.onInventoryEditModalOpen,
                    onSpellAddModalOpen: widget.onSpellAddModalOpen,
                    onSpellEditModalOpen: widget.onSpellEditModalOpen,
                    onClose: widget.onClose,
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
                    onClearStatusKdDebuff: _onClearStatusKdDebuff,
                    onClearStatusKdBuff: _onClearStatusKdBuff,
                    onClearStatusRoped: _onClearStatusRoped,
                    onClearStatusDmgBuff: _onClearStatusDmgBuff,
                    onClearStatusFreezed: _onClearStatusFreezed,
                  ),
                ),
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
        .copyWith(statusKdDebuff: kdDebuff == 0 ? 1 : 0);

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
        .copyWith(statusKdBuff: kdBuff == 0 ? 1 : 0);

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
        .copyWith(statusRoped: roped == 0 ? 1 : 0);

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
        .copyWith(statusDmgBuff: dmgBuff == 0 ? 1 : 0);

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
        .copyWith(statusFreezed: freezed == 0 ? 1 : 0);

    final CharBook updatedCharbook =
        widget.charbooks[widget.charbookIndex].copyWith(
      chars: charList,
    );
    widget.charbookBox.putAt(widget.charbookIndex, updatedCharbook);

    widget.onUpdateScreen();
  }
}

class _UnweappedCard extends StatelessWidget {
  final Character character;
  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
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
  final VoidCallback onClearStatusKdDebuff;
  final VoidCallback onClearStatusKdBuff;
  final VoidCallback onClearStatusRoped;
  final VoidCallback onClearStatusDmgBuff;
  final VoidCallback onClearStatusFreezed;

  const _UnweappedCard({
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
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
    required this.onClearStatusKdDebuff,
    required this.onClearStatusKdBuff,
    required this.onClearStatusRoped,
    required this.onClearStatusDmgBuff,
    required this.onClearStatusFreezed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      horizontal: 32.0,
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
                      onClearStatusKdDebuff: onClearStatusKdDebuff,
                      onClearStatusKdBuff: onClearStatusKdBuff,
                      onClearStatusRoped: onClearStatusRoped,
                      onClearStatusDmgBuff: onClearStatusDmgBuff,
                      onClearStatusFreezed: onClearStatusFreezed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: InkWell(
                onTap: onEdit,
                child: const Icon(
                  Icons.edit,
                  size: 16,
                  color: ColorPalette.attKD,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onChangeWrap,
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
                onTap: onClose,
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
    );
  }
}

class _WrappedCard extends StatelessWidget {
  final Character character;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onEdit;
  final VoidCallback onChangeWrap;
  final VoidCallback onTapStatusKdDebuff;
  final VoidCallback onTapStatusKdBuff;
  final VoidCallback onTapStatusRoped;
  final VoidCallback onTapStatusDmgBuff;
  final VoidCallback onTapStatusFreezed;
  final VoidCallback onClearStatusKdDebuff;
  final VoidCallback onClearStatusKdBuff;
  final VoidCallback onClearStatusRoped;
  final VoidCallback onClearStatusDmgBuff;
  final VoidCallback onClearStatusFreezed;

  const _WrappedCard({
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onImageUpdate,
    required this.onEdit,
    required this.onChangeWrap,
    required this.onTapStatusKdDebuff,
    required this.onTapStatusKdBuff,
    required this.onTapStatusRoped,
    required this.onTapStatusDmgBuff,
    required this.onTapStatusFreezed,
    required this.onClearStatusKdDebuff,
    required this.onClearStatusKdBuff,
    required this.onClearStatusRoped,
    required this.onClearStatusDmgBuff,
    required this.onClearStatusFreezed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          CharacterCardWrappedHeader(
            character: character,
            onPlus: onPlus,
            onMinus: onMinus,
            onReturnDefaultHP: onReturnDefaultHP,
            onImageUpdate: onImageUpdate,
          ),
          const SizedBox(height: 4),
          CharacterAttrBadges(
            character: character,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: StatusEffectsRow(
              alignment: StatusEffectsRowAlignment.spaceBetween,
              character: character,
              onTapStatusKdDebuff: onTapStatusKdDebuff,
              onTapStatusKdBuff: onTapStatusKdBuff,
              onTapStatusRoped: onTapStatusRoped,
              onTapStatusDmgBuff: onTapStatusDmgBuff,
              onTapStatusFreezed: onTapStatusFreezed,
              onClearStatusKdDebuff: onClearStatusKdDebuff,
              onClearStatusKdBuff: onClearStatusKdBuff,
              onClearStatusRoped: onClearStatusRoped,
              onClearStatusDmgBuff: onClearStatusDmgBuff,
              onClearStatusFreezed: onClearStatusFreezed,
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: InkWell(
                  onTap: onEdit,
                  child: Icon(
                    Icons.edit,
                    size: 16,
                    color: ColorPalette.attKD.withOpacity(0.4),
                  ),
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onChangeWrap,
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
    );
  }
}
