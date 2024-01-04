import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageUpdateModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final VoidCallback onImageUpdate;

  ImageUpdateModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onImageUpdate,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final link = TextEditingController();
        try {
          link.text = charbooks[charbookIndex].chars[index].imageUrl;
        } catch (e) {
          print(e);
        }

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
                List<Character> charList = charbooks[charbookIndex].chars;
                charList[index] =
                    charbooks[charbookIndex].chars[index].copyWith(
                          imageUrl: link.text,
                        );
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  chars: charList,
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

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
    print('Image updated!');
  }
}
