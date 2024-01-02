import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SpellEditSpellModal {
  final Box box;
  final int index;
  final int spellIndex;
  final VoidCallback onEditSpell;

  SpellEditSpellModal({
    required this.box,
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
          char = box.getAt(index)!;
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
                  maxLines: 3,
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
                    width: 380,
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
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final newSpell = Spell(
                  name: name.text,
                  description: description.text,
                  dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                  dice: dice.text.isEmpty ? null : int.parse(dice.text),
                  cast: cast.text.isEmpty ? null : int.parse(cast.text),
                  castModifier: cast.text.isEmpty
                      ? null
                      : char.spells[spellIndex].castModifier,
                  energyOnCast: energyOnCast.text.isEmpty
                      ? null
                      : int.parse(energyOnCast.text),
                  energyDescription: energyDescription.text.isEmpty
                      ? null
                      : energyDescription.text,
                );

                List<Spell> spells = char.spells;
                spells[spellIndex] = newSpell;
                final Character changedCharacter =
                    char.copyWith(spells: spells);

                box.putAt(index, changedCharacter);
                _updateScreen();

                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                cast.dispose();
                energyOnCast.dispose();
                energyDescription.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Готово'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрыть'),
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
