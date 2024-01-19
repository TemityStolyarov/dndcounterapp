import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SpellEditSpellModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final int spellIndex;
  final VoidCallback onEditSpell;

  SpellEditSpellModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.spellIndex,
    required this.onEditSpell,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Character char = Character.empty();
        late Spell editingSpell;
        try {
          char = charbooks[charbookIndex].chars[index];
          editingSpell = char.spells[spellIndex];
        } catch (e) {
          print(e);
        }

        final name = TextEditingController();
        name.text = editingSpell.name;
        final description = TextEditingController();
        description.text = editingSpell.description ?? '';
        final dice = TextEditingController();
        dice.text =
            editingSpell.dice != null ? editingSpell.dice.toString() : '';
        final dmg = TextEditingController();
        dmg.text = editingSpell.dmg != null ? editingSpell.dmg.toString() : '';
        final cast = TextEditingController();
        cast.text =
            editingSpell.cast != null ? editingSpell.cast.toString() : '';
        final energyOnCast = TextEditingController();
        energyOnCast.text = editingSpell.energyOnCast != null
            ? editingSpell.energyOnCast.toString()
            : '';
        final energyDescription = TextEditingController();
        energyDescription.text = editingSpell.energyDescription ?? '';
        final type = TextEditingController();
        type.text = tryParseSpellTypeToString(editingSpell.type);

        return AlertDialog(
          title: const Text('Редактирование заклинания'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: name,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Название заклинания',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: description,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Описание',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 140,
                    child: TextField(
                      autofocus: true,
                      controller: dice,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Кубики',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 140,
                    child: TextField(
                      autofocus: true,
                      controller: dmg,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Урон',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      autofocus: true,
                      controller: cast,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Использования',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextField(
                      autofocus: true,
                      controller: energyOnCast,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Энергия',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      autofocus: true,
                      controller: energyDescription,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Описание энергии',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 180,
                    child: TextField(
                      autofocus: true,
                      controller: type,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Тип (A/P/W/M/U)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                List<Spell> newSpells =
                    charbooks[charbookIndex].chars[index].spells;
                newSpells.removeAt(spellIndex);

                Character char = charbooks[charbookIndex].chars[index].copyWith(
                      spells: newSpells,
                    );

                List<Character> newCharList = charbooks[charbookIndex].chars;
                newCharList[index] = char;

                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  chars: newCharList,
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                cast.dispose();
                energyOnCast.dispose();
                energyDescription.dispose();
                type.dispose();

                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
            const SizedBox(width: 276),
            TextButton(
              onPressed: () {
                final newSpell = Spell(
                  name: name.text,
                  description: description.text,
                  dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                  dice: dice.text.isEmpty ? null : int.parse(dice.text),
                  cast: cast.text.isEmpty ? null : int.parse(cast.text),
                  castModifier: char.spells[spellIndex].castModifier ?? 0,
                  energyOnCast: energyOnCast.text.isEmpty
                      ? null
                      : int.parse(energyOnCast.text),
                  energyDescription: energyDescription.text.isEmpty
                      ? null
                      : energyDescription.text,
                  type: tryParseStringToSpellType(type.text),
                );

                List<Character> charList = charbooks[charbookIndex].chars;
                charList[index].spells[spellIndex] = newSpell;
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(chars: charList);
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                cast.dispose();
                energyOnCast.dispose();
                energyDescription.dispose();
                type.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Готово'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отменить'),
            ),
          ],
        );
      },
    );
  }

  void _updateScreen() {
    onEditSpell();
    print('Spell edited!');
  }
}
