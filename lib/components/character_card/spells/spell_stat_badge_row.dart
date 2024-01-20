import 'package:dndcounterapp/components/character_card/spells/spell_stat_badge.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:flutter/material.dart';

class SpellStatBadgeRow extends StatelessWidget {
  const SpellStatBadgeRow({
    super.key,
    required this.showDmg,
    required this.spell,
    required this.showMechanics,
    required this.showCast,
  });

  final bool showDmg;
  final bool showMechanics;
  final bool showCast;
  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDmg)
          SpellStatBadge(
            type: SpellStatBadgeType.dmg,
            label: 'DMG: ${spell.dice}d${spell.dmg}',
          ),
        if (showDmg) const SizedBox(width: 4),
        if (showCast)
          SpellStatBadge(
            type: SpellStatBadgeType.mechanics,
            label: '${spell.cast! + spell.castModifier!} / ${spell.cast}',
          ),
        if (showCast) const SizedBox(width: 4),
        if (showMechanics)
          SpellStatBadge(
            type: SpellStatBadgeType.cast,
            label:
                '${spell.energyDescription}: ${_isPositive(spell.energyOnCast!)}',
          ),
      ],
    );
  }

  String _isPositive(int value) {
    if (value > 0) {
      return '+$value';
    }
    return value.toString();
  }
}
