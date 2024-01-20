import 'dart:convert';

import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryAddModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final VoidCallback onAddItem;

  InventoryAddModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onAddItem,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final name = TextEditingController();
        final description = TextEditingController();
        final dice = TextEditingController();
        final dmg = TextEditingController();
        final dmgBuff = TextEditingController();
        final type = TextEditingController();
        final amount = TextEditingController();

        final kd = TextEditingController();
        final kdPierceBuff = TextEditingController();
        final ctrJson = TextEditingController();

        return AlertDialog(
          title: const Text('Добавление предмета'),
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
                  controller: ctrJson,
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
                if (ctrJson.text.isEmpty) {
                  final newItem = Weapon(
                    name: name.text,
                    description: description.text,
                    dmg: dmg.text.isEmpty ? null : int.parse(dmg.text),
                    dice: dice.text.isEmpty ? null : int.parse(dice.text),
                    kd: kd.text.isEmpty ? null : int.parse(kd.text),
                    amount: amount.text.isEmpty ? 1 : int.parse(amount.text),
                    dmgBuff: dmgBuff.text.isEmpty ? 0 : int.parse(dmgBuff.text),
                    kdPierceBuff: kdPierceBuff.text.isEmpty
                        ? 0
                        : int.parse(kdPierceBuff.text),
                    type: type.text.isEmpty
                        ? WeaponType.usual
                        : tryParseStringToWeaponType(type.text),
                  );

                  List<Character> charList = charbooks[charbookIndex].chars;
                  charList[index].inventory.add(newItem);
                  final CharBook updatedCharbook =
                      charbooks[charbookIndex].copyWith(
                    chars: charList,
                  );
                  charbookBox.putAt(charbookIndex, updatedCharbook);
                } else {
                  final Weapon newWeapon = _getDataFromJson(ctrJson.text);
                  List<Weapon> newInventory =
                      charbooks[charbookIndex].chars[index].inventory;
                  newInventory.add(newWeapon);

                  Character char =
                      charbooks[charbookIndex].chars[index].copyWith(
                            inventory: newInventory,
                          );

                  List<Character> newCharList = charbooks[charbookIndex].chars;
                  newCharList[index] = char;

                  final CharBook updatedCharbook =
                      charbooks[charbookIndex].copyWith(
                    chars: newCharList,
                  );
                  charbookBox.putAt(charbookIndex, updatedCharbook);
                }

                _updateScreen();
                name.dispose();
                description.dispose();
                dmg.dispose();
                dice.dispose();
                kd.dispose();
                amount.dispose();
                dmgBuff.dispose();
                kdPierceBuff.dispose();
                type.dispose();

                Navigator.of(context).pop();
              },
              child: const Text('Добавить'),
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
    onAddItem();
    print('Item added!');
  }

  Weapon _getDataFromJson(String text) {
    Map<String, dynamic> jsonDataList =
        jsonDecode(text).cast<String, dynamic>();

    Weapon weapon = Weapon.fromJson(jsonDataList);

    return weapon;
  }
}
