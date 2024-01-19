import 'package:dndcounterapp/components/character_card/character_stat_blocks/stat_badges/mini_button.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

int modifier(int attr) {
  if (attr >= 30) return 10;
  if (attr >= 28) return 9;
  if (attr >= 26) return 8;
  if (attr >= 24) return 7;
  if (attr >= 22) return 6;
  if (attr >= 20) return 5;
  if (attr >= 18) return 4;
  if (attr >= 16) return 3;
  if (attr >= 14) return 2;
  if (attr >= 12) return 1;
  if (attr >= 10) return 0;
  if (attr >= 8) return -1;
  if (attr >= 6) return -2;
  if (attr >= 4) return -3;
  if (attr >= 2) {
    return -4;
  } else {
    return -5;
  }
}

String uppercaseFirst(String? string) {
  String result = '';

  if (string != null && string.isNotEmpty) {
    result += string.toUpperCase().characters.first;
    result += string.substring(1);
  }

  return result;
}

List<Widget> convertWeaponToText(List<Weapon> inventory) {
  List<Widget> desc = [];
  for (Weapon item in inventory) {
    String itemDesc = '';
    if (item.dice != null && item.kd == null) {
      itemDesc += '${item.dice}d${item.dmg} урона ';
    }

    if (item.kd != null && item.dice == null) {
      itemDesc += 'Дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите ';
    }

    if (item.dice != null && item.kd != null) {
      itemDesc +=
          '${item.dice}d${item.dmg} урона, дает ${!item.kd!.isNegative ? '+' : ''}${item.kd} к защите ';
    }

    if ((item.dice != null && item.dmg != null) &&
        item.description != null &&
        item.description != '') {
      itemDesc += '(${item.description})';
    }

    if ((item.dice == null && item.dmg == null) &&
        item.description != null &&
        item.description != '') {
      itemDesc += uppercaseFirst(item.description);
    }

    desc.add(
      Text(
        item.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
    if (itemDesc.isNotEmpty) {
      desc.add(Text(itemDesc));
    }
    desc.add(const SizedBox(height: 8));
  }
  return desc;
}

List<Widget> convertSpellsToText({
  required List<Spell> spells,
  required int index,
  required Character character,
  required List<CharBook> charbooks,
  required Box charbookBox,
  required int charbookIndex,
  required VoidCallback onUpdateScreen,
}) {
  void onSpellPlusTap(int i) {
    Spell spell = spells[i];
    List<Character> charList = charbooks[charbookIndex].chars;
    charList[index].spells[i] =
        spell.copyWith(castModifier: spells[i].castModifier! + 1);
    final CharBook updatedCharbook =
        charbooks[charbookIndex].copyWith(chars: charList);
    charbookBox.putAt(charbookIndex, updatedCharbook);
    onUpdateScreen();
  }

  void onSpellMinusTap(int i) {
    Spell spell = spells[i];
    List<Character> charList = charbooks[charbookIndex].chars;
    charList[index].spells[i] =
        spell.copyWith(castModifier: spells[i].castModifier! - 1);
    final CharBook updatedCharbook =
        charbooks[charbookIndex].copyWith(chars: charList);
    charbookBox.putAt(charbookIndex, updatedCharbook);
    onUpdateScreen();
  }

  List<Widget> desc = [];
  for (int i = 0; i < spells.length; i++) {
    String spellDesc = '';
    if (spells[i].dice != null && spells[i].dmg != null) {
      spellDesc += '${spells[i].dice}d${spells[i].dmg} урона';
    }

    if (spells[i].dice != null &&
        spells[i].dmg != null &&
        spells[i].energyOnCast != null &&
        spells[i].energyDescription != null) {
      spellDesc +=
          ', при применении -${spells[i].energyOnCast} ${spells[i].energyDescription}';
    }

    if (spells[i].dice == null &&
        spells[i].dmg == null &&
        spells[i].energyOnCast != null &&
        spells[i].energyDescription != null) {
      spellDesc +=
          'При применении -${spells[i].energyOnCast} ${spells[i].energyDescription}';
    }

    if (((spells[i].dice != null && spells[i].dmg != null) ||
            (spells[i].energyOnCast != null &&
                spells[i].energyDescription != null)) &&
        spells[i].description != null &&
        spells[i].description != '') {
      spellDesc += ' (${spells[i].description})';
    }

    if ((spells[i].dice == null &&
            spells[i].dmg == null &&
            spells[i].energyOnCast == null &&
            spells[i].energyDescription == null) &&
        spells[i].description != null &&
        spells[i].description != '') {
      spellDesc += '${spells[i].description}';
    }

    if (spells[i].cast != null && spells[i].castModifier != null) {
      desc.add(
        Row(
          children: [
            Text(
              '${spells[i].name} (${spells[i].cast! + spells[i].castModifier!}/${spells[i].cast})',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MiniButton(
                icon: Icons.remove,
                onTap: () => onSpellMinusTap(i),
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: MiniButton(
                icon: Icons.add,
                onTap: () => onSpellPlusTap(i),
              ),
            ),
          ],
        ),
      );
    } else {
      desc.add(
        Text(
          spells[i].name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      );
    }
    if (spellDesc.isNotEmpty) {
      desc.add(Text(spellDesc));
    }
    desc.add(const SizedBox(height: 8));
  }
  return desc;
}

  String tryParseTypeToString(WeaponType? type) {
    if (type == WeaponType.active) {
      return 'a';
    }
    if (type == WeaponType.passive) {
      return 'p';
    }
    if (type == WeaponType.usedWhen) {
      return 'w';
    }
    return 'u';
  }

  WeaponType? tryParseStringToType(String text) {
    if ('a'.contains(text)) {
      return WeaponType.active;
    }
    if ('p'.contains(text)) {
      return WeaponType.passive;
    }
    if ('w'.contains(text)) {
      return WeaponType.usedWhen;
    }
    return WeaponType.usual;
  }