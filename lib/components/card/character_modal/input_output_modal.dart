import 'dart:convert';

import 'package:dndcounterapp/core/models/character.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterIOModal {
  final Box box;
  final List<Character> chars;
  final VoidCallback onImport;
  final String json;

  CharacterIOModal({
    required this.box,
    required this.chars,
    required this.onImport,
    required this.json,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ctrJSON = TextEditingController();
        ctrJSON.text = json;

        return AlertDialog(
          title: const Text('Импорт/Экспорт персонажей'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 700,
                child: TextField(
                  autofocus: true,
                  controller: ctrJSON,
                  maxLines: 20,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'JSON код',
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
              onPressed: () async {
                List<Map<String, dynamic>> jsonDataList =
                    jsonDecode(ctrJSON.text).cast<Map<String, dynamic>>();

                List<Character> characters = jsonDataList
                    .map((json) => Character.fromJson(json))
                    .toList();

                await _deleteContaining();

                await _addFromJson(characters);

                _updateScreen();

                ctrJSON.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Сохранить'),
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
    onImport();
  }

  _deleteContaining() {
    for (int i = 0; i < chars.length; i++) {
      box.deleteAt(0);
    }
  }

  _addFromJson(List<Character> characters) {
    for (var char in characters) {
      print('${char.name} added!');
      box.add(char);
    }
  }
}
