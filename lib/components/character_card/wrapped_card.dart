

import 'package:dndcounterapp/components/character_card/character_description_blocks/character_attr_badges.dart';
import 'package:dndcounterapp/components/character_card/character_description_blocks/character_card_wrapped_header.dart';
import 'package:dndcounterapp/components/character_card/character_description_blocks/stat_badges/status_effects_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class WrappedCard extends StatelessWidget {
  final Character character;

  final VoidCallback onPlus;
  final VoidCallback onMinus;
  final VoidCallback onReturnDefaultHP;
  final VoidCallback onSetHP;
  final VoidCallback onImageUpdate;
  final VoidCallback onEdit;
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
    required this.character,
    required this.onPlus,
    required this.onMinus,
    required this.onReturnDefaultHP,
    required this.onSetHP,
    required this.onImageUpdate,
    required this.onEdit,
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
            onSetHP: onSetHP,
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
