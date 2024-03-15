import 'package:dndcounterapp/components/character_card/weapons/weapon_stat_badge_row.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class ChatacterWeaponListItem extends StatelessWidget {
  const ChatacterWeaponListItem({
    super.key,
    required this.index,
    required this.weapon,
    required this.onWeaponItemTap,
  });

  final int index;
  final Weapon weapon;
  final VoidCallback onWeaponItemTap;

  @override
  Widget build(BuildContext context) {
    const double maxWidth = 480; //380.0;
    const double minWidth = 0;

    final showAmount = weapon.amount != null && weapon.amount != 1;
    final showDescription =
        weapon.description != null && weapon.description!.isNotEmpty;

    final showDmg = weapon.dmg != null &&
        weapon.dmg != 0 &&
        weapon.dice != null &&
        weapon.dice != 0;
    final showDmgBuff = weapon.dmgBuff != null && weapon.dmgBuff != 0;
    final showKd = weapon.kd != null && weapon.kd != 0;
    final showHit = weapon.kdPierceBuff != null && weapon.kdPierceBuff != 0;
    final showBadges = showDmg || showDmgBuff || showKd || showHit;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onWeaponItemTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            border: Border.all(
              color: ColorPalette.fontBaseColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _WeaponHeader(
                    maxWidth: maxWidth,
                    minWidth: minWidth,
                    weapon: weapon,
                    showAmount: showAmount,
                    showBadges: showBadges,
                    showDmg: showDmg,
                    showDmgBuff: showDmgBuff,
                    showKd: showKd,
                    showHit: showHit,
                  ),
                  if (showDescription) const SizedBox(height: 2),
                  if (showDescription)
                    _WeaponDescription(
                      weapon: weapon,
                      maxWidth: maxWidth,
                      minWidth: minWidth,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WeaponHeader extends StatelessWidget {
  const _WeaponHeader({
    required this.maxWidth,
    required this.weapon,
    required this.showAmount,
    required this.showBadges,
    required this.showDmg,
    required this.showDmgBuff,
    required this.showKd,
    required this.showHit,
    required this.minWidth,
  });

  final double maxWidth;
  final double minWidth;
  final Weapon weapon;
  final bool showAmount;
  final bool showBadges;
  final bool showDmg;
  final bool showDmgBuff;
  final bool showKd;
  final bool showHit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: minWidth,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          weapon.type == WeaponType.usual
              ? const SizedBox.shrink()
              : Image.asset(
                  _selectAssetByType(weapon.type),
                  height: 10,
                ),
          if (weapon.type != WeaponType.usual) const SizedBox(width: 4),
          Text(
            weapon.name,
            style: const TextStyle(
              fontSize: 12,
              height: 14 / 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showAmount)
            Text(
              ' x${weapon.amount}',
              style: const TextStyle(
                fontSize: 12,
                height: 14 / 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          if (showBadges) const SizedBox(width: 4),
          if (showBadges)
            WeaponStatBadgeRow(
              showDmg: showDmg,
              showDmgBuff: showDmgBuff,
              showKd: showKd,
              showHit: showHit,
              weapon: weapon,
            ),
        ],
      ),
    );
  }

  String _selectAssetByType(WeaponType? type) {
    switch (type) {
      case WeaponType.active:
        return 'assets/images/active.png';
      case WeaponType.passive:
        return 'assets/images/passive.png';
      case WeaponType.usedWhen:
        return 'assets/images/usedWhen.png';
      default:
        return 'assets/images/active.png';
    }
  }
}

class _WeaponDescription extends StatelessWidget {
  const _WeaponDescription({
    required this.maxWidth,
    required this.weapon,
    required this.minWidth,
  });
  final double maxWidth;
  final double minWidth;
  final Weapon weapon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        minWidth: minWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weapon.description!,
            style: const TextStyle(
              fontSize: 12,
              height: 14 / 12,
            ),
          )
        ],
      ),
    );
  }
}
