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

String tryParseWeaponTypeToString(WeaponType? type) {
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

String tryParseSpellTypeToString(SpellType? type) {
  if (type == SpellType.active) {
    return 'a';
  }
  if (type == SpellType.passive) {
    return 'p';
  }
  if (type == SpellType.usedWhen) {
    return 'w';
  }
  if (type == SpellType.mechanics) {
    return 'm';
  }
  return 'u';
}

WeaponType? tryParseStringToWeaponType(String text) {
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

SpellType? tryParseStringToSpellType(String text) {
  if ('a'.contains(text)) {
    return SpellType.active;
  }
  if ('p'.contains(text)) {
    return SpellType.passive;
  }
  if ('w'.contains(text)) {
    return SpellType.usedWhen;
  }
  if ('m'.contains(text)) {
    return SpellType.mechanics;
  }
  return SpellType.usual;
}

void onSpellPlusTap({
  required int spellIndex,
  required List<Spell> spells,
  required List<CharBook> charbooks,
  required int charbookIndex,
  required int charIndex,
  required Box charbookBox,
  required VoidCallback onUpdateScreen,
}) {
  Spell spell = spells[spellIndex];
  List<Character> charList = charbooks[charbookIndex].chars;
  charList[charIndex].spells[spellIndex] =
      spell.copyWith(castModifier: spells[spellIndex].castModifier! + 1);
  final CharBook updatedCharbook =
      charbooks[charbookIndex].copyWith(chars: charList);
  charbookBox.putAt(charbookIndex, updatedCharbook);
  onUpdateScreen();
}

void onSpellMinusTap({
  required int spellIndex,
  required List<Spell> spells,
  required List<CharBook> charbooks,
  required int charbookIndex,
  required int charIndex,
  required Box charbookBox,
  required VoidCallback onUpdateScreen,
}) {
  Spell spell = spells[spellIndex];
  List<Character> charList = charbooks[charbookIndex].chars;
  charList[charIndex].spells[spellIndex] =
      spell.copyWith(castModifier: spells[spellIndex].castModifier! - 1);
  final CharBook updatedCharbook =
      charbooks[charbookIndex].copyWith(chars: charList);
  charbookBox.putAt(charbookIndex, updatedCharbook);
  onUpdateScreen();
}
