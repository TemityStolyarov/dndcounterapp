import 'dart:convert';

import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharbookEditModal {
  final Box box;
  final int charbookIndex;
  final VoidCallback onUpdateScreen;

  CharbookEditModal({
    required this.box,
    required this.charbookIndex,
    required this.onUpdateScreen,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        CharBook charbook = CharBook.empty();
        try {
          charbook = box.getAt(charbookIndex);
        } catch (e) {
          print(e);
        }

        final ctrLabel = TextEditingController();
        ctrLabel.text = charbook.name;
        final ctrJSON = TextEditingController();
        ctrJSON.text =
            jsonEncode(charbook.chars.map((char) => char.toJson()).toList());

        return AlertDialog(
          title: const Text('Редактирование раздела'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 466,
                child: TextField(
                  autofocus: true,
                  controller: ctrLabel,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Название раздела',
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
                width: 466,
                child: TextField(
                  autofocus: true,
                  controller: ctrJSON,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'JSON код',
                    labelStyle: TextStyle(fontSize: 14),
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
                box.deleteAt(charbookIndex);
                _updateScreen();

                ctrLabel.dispose();
                ctrJSON.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Удалить'),
            ),
            const SizedBox(width: 230),
            TextButton(
              onPressed: () {
                final CharBook section = CharBook(
                  name: ctrLabel.text,
                  chars: ctrJSON.text.isEmpty
                      ? []
                      : _getCharsFromJson(ctrJSON.text),
                  coins: charbook.coins,
                );

                box.putAt(charbookIndex, section);
                _updateScreen();

                ctrLabel.dispose();
                ctrJSON.dispose();
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
    onUpdateScreen();
    print('Character added!');
  }

  _getCharsFromJson(String text) {
    List<Map<String, dynamic>> jsonDataList =
        jsonDecode(text).cast<Map<String, dynamic>>();

    List<Character> chars =
        jsonDataList.map((json) => Character.fromJson(json)).toList();

    return chars;
  }
}
