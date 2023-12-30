import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterDescriptionInventoryModal {
  final Box box;
  final int index;
  final VoidCallback onAddItem;

  CharacterDescriptionInventoryModal({
    required this.box,
    required this.index,
    required this.onAddItem,
  });

  void showCharacterInventoryModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final name = TextEditingController();
        final description = TextEditingController();
        final dice = TextEditingController();
        final dmg = TextEditingController();
        final kd = TextEditingController();

        return AlertDialog(
          title: const Text('Добавление предмета'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: name,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Имя персонажа',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
              TextField(
                autofocus: true,
                controller: description,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 14),
                  labelText: 'Имя персонажа',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final newItem = Weapon(
                  name: name.text,
                  description: description.text,
                  dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                  dice: dice.text.isEmpty ? null : int.parse(dice.text),
                  kd: kd.text.isEmpty ? null : int.parse(kd.text),
                );

                final Character character = box.getAt(index);
                List<Weapon> inventory = character.inventory;
                inventory.add(newItem);
                final Character newChar =
                    character.copyWith(inventory: inventory);

                box.putAt(index, newChar);
                _updateScreen();

                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                kd.dispose();

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
    onAddItem();
    print('Character added!');
  }
}
