import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterDescriptionSpellModal {
  final Box box;
  final int index;
  final VoidCallback onAddSpell;

  CharacterDescriptionSpellModal({
    required this.box,
    required this.index,
    required this.onAddSpell,
  });

  void showCharacterSpellModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final name = TextEditingController();
        final description = TextEditingController();
        final dice = TextEditingController();
        final dmg = TextEditingController();
        final cost = TextEditingController();

        // TODO
        return AlertDialog(
          title: const Text('Добавление заклинания'),
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
                      controller: cost,
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
                  cost: cost.text.isEmpty ? null : int.parse(cost.text),
                  costModifier: cost.text.isEmpty ? null : 0,
                );

                final Character character = box.getAt(index);
                List<Spell> spells = character.spells;
                spells.add(newSpell);
                final Character newChar = character.copyWith(spells: spells);

                box.putAt(index, newChar);
                _updateScreen();

                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                cost.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
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
    onAddSpell();
    print('Spell added!');
  }
}
