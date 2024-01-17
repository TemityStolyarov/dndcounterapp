import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SetHPModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final VoidCallback onSetHP;

  SetHPModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onSetHP,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final hp = TextEditingController();
        final hpModifierCtr = TextEditingController();
        try {
          hp.text = (charbooks[charbookIndex].chars[index].hp +
                  charbooks[charbookIndex].chars[index].hpModifier)
              .toString();
        } catch (e) {
          print(e);
        }

        return AlertDialog(
          title: const Text('Изменение ХП'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: hp,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Количество текущего ХП',
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
                  controller: hpModifierCtr,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Добавочный урон ( - ) / восстановление ( + )',
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
                List<Character> charList = charbooks[charbookIndex].chars;
                int value = -charbooks[charbookIndex].chars[index].hp +
                    int.parse(hp.text);
                if (hpModifierCtr.text.isNotEmpty) {
                  value += int.parse(hpModifierCtr.text);
                }
                charList[index] =
                    charbooks[charbookIndex].chars[index].copyWith(
                          hpModifier: value,
                        );
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  chars: charList,
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                hp.dispose();
                hpModifierCtr.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
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
    onSetHP();
    print('HP set!');
  }
}
