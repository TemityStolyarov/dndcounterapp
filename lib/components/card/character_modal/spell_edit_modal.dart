import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SpellEditModal {
  final Box box;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  SpellEditModal({
    required this.box,
    required this.index,
    required this.onDelete,
    required this.onEdit,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final Character char = box.getAt(index);
        return AlertDialog(
          title: const Text('Редактирование книги заклинаний'),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _spellsToList(
                  spells: char.spells,
                  characterIndex: index,
                ),
              ),
            ),
          ),
          actions: <Widget>[
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

  List<Widget> _spellsToList({
    required List<Spell> spells,
    required int characterIndex,
  }) {
    List<Widget> list = [];

    for (int i = 0; i < spells.length; i++) {
      if (list.isNotEmpty) list.add(const SizedBox(height: 14));

      final Widget card = Container(
        width: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorPalette.cubeRolling.withOpacity(0.05)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 370,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${i + 1}. '),
                        Text(
                          spells[i].name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if (spells[i].dice != null &&
                            spells[i].dmg != null &&
                            spells[i].cast != null &&
                            spells[i].castModifier != null)
                          Text(
                              ' (${spells[i].dice}d${spells[i].dmg} DMG, ${spells[i].cast! + spells[i].castModifier!}/${spells[i].cast})'),
                        if (spells[i].dice != null &&
                            spells[i].dmg != null &&
                            spells[i].cast == null)
                          Text(' (${spells[i].dice}d${spells[i].dmg} DMG)'),
                        if (spells[i].dice == null &&
                            spells[i].dmg == null &&
                            spells[i].cast != null &&
                            spells[i].castModifier != null)
                          Text(
                              ' (${spells[i].cast! + spells[i].castModifier!}/${spells[i].cast})'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    spells[i].description != null
                        ? Text(spells[i].description!)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const Spacer(),
              // TODO: handle EDIT tap
              Container(
                decoration: BoxDecoration(
                  color: ColorPalette.cubeRolling.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // TODO: handle DELETE tap
              Container(
                decoration: BoxDecoration(
                  color: ColorPalette.cubeRolling.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      list.add(card);
    }

    return list;
  }
}
