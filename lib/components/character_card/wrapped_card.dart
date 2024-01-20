import 'package:dndcounterapp/components/character_card/character_card_window_navigation.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/character_attr_badges_wrapped.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/character_card_wrapped_header.dart';
import 'package:dndcounterapp/components/character_card/character_stat_blocks/status_effects/status_effects_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class WrappedCard extends StatelessWidget {
  final Character character;
  final bool isWrapped;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onEdit;
  final VoidCallback onClose;
  final VoidCallback onChangeWrap;

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

  const WrappedCard({
    super.key,
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onSetHP,
    required this.onImageUpdate,
    required this.onEdit,
    required this.onClose,
    required this.onChangeWrap,
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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ChatacterCardWindowNavigation(
            onEdit: onEdit,
            onChangeWrap: onChangeWrap,
            onClose: onClose,
            isWrapped: isWrapped,
          ),
          const SizedBox(height: 2),
          CharacterCardWrappedHeader(
            character: character,
            onPlus: onPlus,
            onMinus: onMinus,
            onReturnDefaultHP: onReturnDefaultHP,
            onSetHP: onSetHP,
            onImageUpdate: onImageUpdate,
          ),
          const SizedBox(height: 4),
          CharacterAttrBadgesWrapped(
            character: character,
            textStyle: const TextStyle(
              fontSize: 12,
              color: ColorPalette.cardColor,
              fontWeight: FontWeight.w500,
            ),
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
    );
  }
}
