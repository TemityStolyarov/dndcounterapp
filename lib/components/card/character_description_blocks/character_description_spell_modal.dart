import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/spell.dart';
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
        final costModifier = TextEditingController();

        return AlertDialog(
          title: const Text('Добавление заклинания'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  SizedBox(
                    child: TextField(
                      autofocus: true,
                      controller: name,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Название',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  SizedBox(
                    child: TextField(
                      autofocus: true,
                      controller: description,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Класс',
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
                  costModifier: costModifier.text.isEmpty
                      ? 0
                      : int.parse(costModifier.text),
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
                costModifier.dispose();
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
