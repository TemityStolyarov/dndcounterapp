import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CoinsModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final VoidCallback onCoinsUpdate;

  CoinsModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.onCoinsUpdate,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final coins = TextEditingController();
        try {
          coins.text = charbooks[charbookIndex].coins == null
              ? '0'
              : charbooks[charbookIndex].coins.toString();
        } catch (e) {
          print(e);
        }

        return AlertDialog(
          title: const Text('Монеты'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  autofocus: true,
                  controller: coins,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 14),
                    labelText: 'Количество монет',
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
                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  coins: int.parse(coins.text),
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                coins.dispose();
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
    onCoinsUpdate();
    print('Image updated!');
  }
}
