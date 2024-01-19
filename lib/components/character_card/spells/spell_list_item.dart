import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';

class ChatacterSpellListItem extends StatelessWidget {
  const ChatacterSpellListItem({
    super.key,
    required this.index,
    required this.spell,
    required this.onSpellItemTap,
  });

  final int index;
  final Spell spell;
  final VoidCallback onSpellItemTap;

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        spell.description!.length > 180 ? 780 : 380; // 246 x3; //380.0 x2;
    const double minWidth = 380;
    const double maxHeight = 80;
    const double minHeight = 28;

    // final showAmount = weapon.amount != null && weapon.amount != 1;
    final showDescription =
        spell.description != null && spell.description!.isNotEmpty;

    final showDmg = spell.dmg != null &&
        spell.dmg != 0 &&
        spell.dice != null &&
        spell.dice != 0;
    final showCast = spell.cast != null && spell.cast != 0;
    // final showBadges = showDmg || showDmgBuff || showKd || showHit;

    return spell.type == SpellType.mechanics
        ? _ManaSpellItem()
        : Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: onSpellItemTap,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  border: Border.all(
                    color: ColorPalette.fontBaseColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                      minWidth: minWidth,
                      maxHeight: maxHeight,
                      minHeight: minHeight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SpellHeader(
                          spell: spell,
                          // showAmount: showAmount,
                          // showBadges: showBadges,
                          // showDmg: showDmg,
                          // showDmgBuff: showDmgBuff,
                          // showKd: showKd,
                          // showHit: showHit,
                        ),
                        if (showDescription) const SizedBox(height: 2),
                        if (showDescription)
                          _SpellDescription(
                            spell: spell,
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

class _ManaSpellItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _SpellHeader extends StatelessWidget {
  const _SpellHeader({
    required this.spell,
  });

  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        spell.type == SpellType.usual
            ? const SizedBox.shrink()
            : Image.asset(
                _selectAssetByType(spell.type),
                height: 10,
              ),
        if (spell.type != SpellType.usual) const SizedBox(width: 4),
        Text(
          spell.name,
          style: const TextStyle(
            fontSize: 12,
            height: 14 / 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        // if (showAmount)
        //   Text(
        //     ' x${weapon.amount}',
        //     style: const TextStyle(
        //       fontSize: 12,
        //       height: 14 / 12,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
      ],
    );
  }

  String _selectAssetByType(SpellType? type) {
    switch (type) {
      case SpellType.active:
        return 'assets/images/active.png';
      case SpellType.passive:
        return 'assets/images/passive.png';
      case SpellType.usedWhen:
        return 'assets/images/usedWhen.png';
      default:
        return 'assets/images/active.png';
    }
  }
}

class _SpellDescription extends StatelessWidget {
  const _SpellDescription({
    required this.spell,
  });
  final Spell spell;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          spell.description!,
          style: const TextStyle(
            fontSize: 12,
            height: 14 / 12,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
        // if (showBadges) const SizedBox(width: 4),
        // if (showBadges)
        //   WeaponStatBadgeRow(
        //     showDmg: showDmg,
        //     showDmgBuff: showDmgBuff,
        //     showKd: showKd,
        //     showHit: showHit,
        //     weapon: weapon,
        //   ),
      ],
    );
  }
}
