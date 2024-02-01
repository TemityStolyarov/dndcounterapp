import 'package:dndcounterapp/components/character_card/character_stat_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/components/character_card/spells/spell_stat_badge_row.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/colors/color_palette.dart';
import 'package:flutter/material.dart';

class ChatacterSpellListItem extends StatelessWidget {
  const ChatacterSpellListItem({
    super.key,
    required this.index,
    required this.spell,
    required this.onSpellItemTap,
    required this.onSpellMinusTap,
    required this.onSpellPlusTap,
  });

  final int index;
  final Spell spell;
  final VoidCallback onSpellItemTap;
  final VoidCallback onSpellMinusTap;
  final VoidCallback onSpellPlusTap;

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        spell.description!.length > 180 ? 780 : 380; // 246 x3; //380.0 x2;
    const double minWidth = 380;
    const double maxHeight = 80;
    const double minHeight = 0;
    const double maxWidthMana = 780;
    const double minWidthMana = 780;

    final showDescription =
        spell.description != null && spell.description!.isNotEmpty;

    final showDmg = spell.dmg != null &&
        spell.dmg != 0 &&
        spell.dice != null &&
        spell.dice != 0;
    final showCast = spell.cast != null && spell.cast != 0;
    final showMechanics = spell.energyOnCast != null && spell.energyOnCast != 0;
    final showBadges = showDmg || showCast || showMechanics;

    return spell.type == SpellType.mechanics
        ? _ManaSpellItem(
            index: index,
            spell: spell,
            onSpellItemTap: onSpellItemTap,
            maxHeight: maxHeight,
            maxWidth: maxWidthMana,
            minHeight: minHeight,
            minWidth: minWidthMana,
            showDmg: showDmg,
            showCast: showCast,
            showMechanics: showMechanics,
            showBadges: showBadges,
            showDescription: showDescription,
            onSpellMinusTap: onSpellMinusTap,
            onSpellPlusTap: onSpellPlusTap,
          )
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
                          showBadges: showBadges,
                          showDmg: showDmg,
                          showCast: showCast,
                          showMechanics: showMechanics,
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
  const _ManaSpellItem({
    required this.index,
    required this.spell,
    required this.onSpellItemTap,
    required this.maxHeight,
    required this.maxWidth,
    required this.minHeight,
    required this.minWidth,
    required this.showDmg,
    required this.showCast,
    required this.showMechanics,
    required this.showBadges,
    required this.showDescription,
    required this.onSpellMinusTap,
    required this.onSpellPlusTap,
  });
  final int index;
  final Spell spell;
  final VoidCallback onSpellItemTap;
  final double maxHeight;
  final double maxWidth;
  final double minHeight;
  final double minWidth;
  final bool showDmg;
  final bool showCast;
  final bool showMechanics;
  final bool showBadges;
  final bool showDescription;
  final VoidCallback onSpellMinusTap;
  final VoidCallback onSpellPlusTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: MiniButton(
                          icon: Icons.remove,
                          onTap: onSpellMinusTap,
                        ),
                      ),
                      _SpellHeader(
                        spell: spell,
                        showBadges: showBadges,
                        showDmg: showDmg,
                        showCast: showCast,
                        showMechanics: showMechanics,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: MiniButton(
                          icon: Icons.add,
                          onTap: onSpellPlusTap,
                        ),
                      ),
                    ],
                  ),
                  if (showCast) const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      ),
                      child: _SpellManaRow(spell: spell),
                    ),
                  ),
                  if (showDescription) const SizedBox(height: 2),
                  if (showDescription)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _SpellDescription(
                        spell: spell,
                      ),
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

class _SpellManaRow extends StatelessWidget {
  const _SpellManaRow({required this.spell});
  final Spell spell;

  @override
  Widget build(Object context) {
    final manaMax = spell.cast!;
    final manaNow = spell.cast! + spell.castModifier!;
    return Container(
      height: 12,
      width: 780,
      decoration: const BoxDecoration(
        color: ColorPalette.backgroundColor30,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: List.generate(
          manaMax,
          (index) {
            Color cellColor = index < manaNow
                ? ColorPalette.attIntelligence
                : ColorPalette.badgeKdBackground;

            BorderRadius borderRadius;
            if (index == 0) {
              borderRadius = const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              );
            } else if (index == manaMax - 1) {
              borderRadius = const BorderRadius.only(
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              );
            } else {
              borderRadius = BorderRadius.zero;
            }

            return Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cellColor,
                  borderRadius: borderRadius,
                ),
                margin: const EdgeInsets.all(0.5),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SpellHeader extends StatelessWidget {
  const _SpellHeader({
    required this.spell,
    required this.showBadges,
    required this.showMechanics,
    required this.showCast,
    required this.showDmg,
  });

  final Spell spell;
  final bool showBadges;
  final bool showMechanics;
  final bool showCast;
  final bool showDmg;

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
        if (showBadges) const SizedBox(width: 4),
        if (showBadges)
          SpellStatBadgeRow(
            showDmg: showDmg,
            showCast: showCast,
            showMechanics: showMechanics,
            spell: spell,
          )
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
      case SpellType.mechanics:
        return 'assets/images/mechanics.png';
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
      ],
    );
  }
}
