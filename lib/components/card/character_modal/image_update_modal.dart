import 'package:dndcounterapp/core/models/character.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageUpdateModal {
  final Box box;
  final int index;
  final VoidCallback onImageUpdate;

  ImageUpdateModal({
    required this.box,
    required this.index,
    required this.onImageUpdate,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final link = TextEditingController();

        return AlertDialog(
          title: const Text('Загрузка аватарки'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: link,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Ссылка',
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
                final Character character = box.getAt(index);

                final Character newChar =
                    character.copyWith(imageUrl: link.text);

                box.putAt(index, newChar);
                _updateScreen();

                link.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Загрузить'),
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
    onImageUpdate();
    print('Spell added!');
  }
}
