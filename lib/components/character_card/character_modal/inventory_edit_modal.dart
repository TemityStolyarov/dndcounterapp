import 'dart:convert';

import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryEditModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final int itemIndex;
  final VoidCallback onEditItem;

  InventoryEditModal({
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
        final dmgBuff = TextEditingController();
        dmgBuff.text =
            editingItem.dmgBuff != null ? editingItem.dmgBuff.toString() : '';
        final kd = TextEditingController();
        kd.text = editingItem.kd != null ? editingItem.kd.toString() : '';
        final kdPierceBuff = TextEditingController();
        kdPierceBuff.text = editingItem.kdPierceBuff != null
            ? editingItem.kdPierceBuff.toString()
            : '';
        final type = TextEditingController();
        type.text = tryParseWeaponTypeToString(editingItem.type);
        final amount = TextEditingController();
        amount.text =
            editingItem.amount != null ? editingItem.amount.toString() : '1';
        final ctrJSON = TextEditingController();
        ctrJSON.text = jsonEncode(charbooks[charbookIndex]
            .chars[index]
            .inventory[itemIndex]
            .toJson());

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
                  maxLines: 5,
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
                      controller: dmgBuff,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Бонус к урону',
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
                    width: 233,
                    child: TextField(
                      autofocus: true,
                      controller: kd,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Бонус к КД',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 233,
                    child: TextField(
                      autofocus: true,
                      controller: kdPierceBuff,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Бонус к попаданию',
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
                    width: 233,
                    child: TextField(
                      autofocus: true,
                      controller: type,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Тип (A/P/W/U)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  SizedBox(
                    width: 233,
                    child: TextField(
                      autofocus: true,
                      controller: amount,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(fontSize: 14),
                        labelText: 'Количество',
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
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: ctrJSON,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'JSON-код',
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
          actions: <Widget>[
            TextButton(
              onPressed: () {
                List<Weapon> newInventory =
                    charbooks[charbookIndex].chars[index].inventory;
                newInventory.removeAt(itemIndex);

                Character char = charbooks[charbookIndex].chars[index].copyWith(
                      inventory: newInventory,
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
                dmgBuff.dispose();
                dice.dispose();
                kd.dispose();
                kdPierceBuff.dispose();
                amount.dispose();
                type.dispose();

                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
            const SizedBox(width: 276),
            TextButton(
              onPressed: () {
                final editedItem = Weapon(
                  name: name.text,
                  description: description.text,
                  dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                  dice: dice.text.isEmpty ? null : int.parse(dice.text),
                  kd: kd.text.isEmpty ? null : int.parse(kd.text),
                  amount: amount.text.isEmpty ? null : int.parse(amount.text),
                  dmgBuff:
                      dmgBuff.text.isEmpty ? null : int.parse(dmgBuff.text),
                  kdPierceBuff: kdPierceBuff.text.isEmpty
                      ? null
                      : int.parse(kdPierceBuff.text),
                  type: tryParseStringToWeaponType(type.text),
                );

                List<Character> charList = charbooks[charbookIndex].chars;
                charList[index].inventory[itemIndex] = editedItem;
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(chars: charList);
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                name.dispose();
                description.dispose();
                dmg.dispose();
                dmgBuff.dispose();
                dice.dispose();
                kd.dispose();
                kdPierceBuff.dispose();
                amount.dispose();
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
    onEditItem();
    print('Item edited!');
  }
}
