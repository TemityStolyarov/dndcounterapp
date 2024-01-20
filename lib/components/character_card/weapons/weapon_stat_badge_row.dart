import 'package:dndcounterapp/components/character_card/weapons/weapon_stat_badge.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';

class WeaponStatBadgeRow extends StatelessWidget {
  const WeaponStatBadgeRow({
    super.key,
    required this.showDmg,
    required this.showDmgBuff,
    required this.showKd,
    required this.showHit,
    required this.weapon,
  });

  final bool showDmg;
  final bool showDmgBuff;
  final bool showKd;
  final bool showHit;
  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showDmg)
          WeaponStatBadge(
            type: WeaponStatBadgeType.dmg,
            label: 'DMG: ${weapon.dice}d${weapon.dmg}',
          ),
        if (showDmg) const SizedBox(width: 4),
        if (showDmgBuff)
          WeaponStatBadge(
            type: WeaponStatBadgeType.dmgBuff,
            label: 'DMG: ${_isPositive(weapon.dmgBuff!)}',
          ),
        if (showDmgBuff) const SizedBox(width: 4),
        if (showKd)
          WeaponStatBadge(
            type: WeaponStatBadgeType.kd,
            label: 'KD: ${_isPositive(weapon.kd!)}',
          ),
        if (showKd) const SizedBox(width: 4),
        if (showHit)
          WeaponStatBadge(
            type: WeaponStatBadgeType.hit,
            label: 'HIT: ${_isPositive(weapon.kdPierceBuff!)}',
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
