import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryEditItemModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final int itemIndex;
  final VoidCallback onEditItem;

  InventoryEditItemModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.itemIndex,
    required this.onEditItem,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Character char = Character.empty();
        late Weapon editingItem;
        try {
          char = charbooks[charbookIndex].chars[index];
          editingItem = char.inventory[itemIndex];
        } catch (e) {
          print(e);
        }

        final name = TextEditingController();
        name.text = editingItem.name;
        final description = TextEditingController();
        description.text = editingItem.description ?? '';
        final dice = TextEditingController();
        dice.text = editingItem.dice != null ? editingItem.dice.toString() : '';
        final dmg = TextEditingController();
        dmg.text = editingItem.dmg != null ? editingItem.dmg.toString() : '';
        final kd = TextEditingController();
        kd.text = editingItem.kd != null ? editingItem.kd.toString() : '';

        return AlertDialog(
          title: const Text('Редактирование предмета'),
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
                    labelText: 'Название предмета',
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
                      controller: kd,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'КД',
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
                final newItem = Weapon(
                  name: name.text,
                  description: description.text,
                  dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                  dice: dice.text.isEmpty ? null : int.parse(dice.text),
                  kd: kd.text.isEmpty ? null : int.parse(kd.text),
                );

                List<Character> charList = charbooks[charbookIndex].chars;
                charList[index].inventory[itemIndex] = newItem;
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(chars: charList);
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                kd.dispose();

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
    onEditItem();
    print('Item edited!');
  }
}
