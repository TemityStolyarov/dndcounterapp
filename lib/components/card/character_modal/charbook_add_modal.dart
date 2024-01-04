import 'dart:convert';

import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharbookAddModal {
  final Box box;
  final VoidCallback onAdd;

  CharbookAddModal({
    required this.box,
    required this.onAdd,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ctrLabel = TextEditingController();
        final ctrJSON = TextEditingController();

        return AlertDialog(
          title: const Text('Добавление раздела'),
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
                final CharBook section = CharBook(
                  name: ctrLabel.text,
                  chars: ctrJSON.text.isEmpty
                      ? []
                      : _getCharsFromJson(ctrJSON.text),
                );

                box.add(section);
                _updateScreen();

                ctrLabel.dispose();
                ctrJSON.dispose();
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
    onAdd();
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
