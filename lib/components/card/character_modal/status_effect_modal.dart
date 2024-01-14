import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum StatusEffect {
  statusKdDebuff,
  statusKdBuff,
  statusRoped,
  statusDmgBuff,
  statusFreezed,
  statusRollBuff,
  statusRollDebuff,
}

class StatusEffectModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;
  final VoidCallback onEdit;
  final StatusEffect statusEffectName;
  final String statusEffectLabel;

  StatusEffectModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onEdit,
    required this.statusEffectName,
    required this.statusEffectLabel,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final status = TextEditingController();
        try {
          status.text = _parseStatusEffectName(statusEffectName);
        } catch (e) {
          print(e);
        }

        return AlertDialog(
          title: const Text('Редактирование статус-эффекта'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 490,
                child: TextField(
                  autofocus: true,
                  controller: status,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(fontSize: 14),
                    labelText: statusEffectLabel,
                    border: const OutlineInputBorder(
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
                charList[index] = _setStatusEffectByName(
                  statusText: '',
                  statusName: statusEffectName,
                );

                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  chars: charList,
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                status.dispose();
                Navigator.of(context).pop();
              },
              child: const Text('Снять эффект'),
            ),
            const SizedBox(width: 220),
            TextButton(
              onPressed: () {
                List<Character> charList = charbooks[charbookIndex].chars;
                charList[index] = _setStatusEffectByName(
                  statusText: status.text,
                  statusName: statusEffectName,
                );

                final CharBook updatedCharbook =
                    charbooks[charbookIndex].copyWith(
                  chars: charList,
                );
                charbookBox.putAt(charbookIndex, updatedCharbook);

                _updateScreen();
                status.dispose();
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

  String _parseStatusEffectName(StatusEffect statusEffectName) {
    final char = charbooks[charbookIndex].chars[index];
    switch (statusEffectName) {
      case StatusEffect.statusKdDebuff:
        return char.statusKdDebuff != null
            ? char.statusKdDebuff.toString()
            : '';
      case StatusEffect.statusKdBuff:
        return char.statusKdBuff!.isNotEmpty ? char.statusKdBuff! : '';
      case StatusEffect.statusRoped:
        return char.statusRoped!.isNotEmpty ? char.statusRoped! : '';
      case StatusEffect.statusDmgBuff:
        return char.statusDmgBuff!.isNotEmpty ? char.statusDmgBuff! : '';
      case StatusEffect.statusFreezed:
        return char.statusFreezed!.isNotEmpty ? char.statusFreezed! : '';
      case StatusEffect.statusRollBuff:
        return char.statusRollBuff!.isNotEmpty ? char.statusRollBuff! : '';
      case StatusEffect.statusRollDebuff:
        return char.statusRollDebuff!.isNotEmpty ? char.statusRollDebuff! : '';
    }
  }

  void _updateScreen() {
    onEdit();
    print('Status effect ${statusEffectLabel} updated!');
  }

  Character _setStatusEffectByName(
      {required String statusText, required StatusEffect statusName}) {
    switch (statusName) {
      case StatusEffect.statusKdDebuff:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusKdDebuff:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusKdBuff:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusKdBuff:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusRoped:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusRoped:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusDmgBuff:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusDmgBuff:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusFreezed:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusFreezed:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusRollBuff:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusRollBuff:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
      case StatusEffect.statusRollDebuff:
        return charbooks[charbookIndex].chars[index].copyWith(
              statusRollDebuff:
                  (statusText == '' || statusText.isEmpty) ? '' : statusText,
            );
    }
  }
}
