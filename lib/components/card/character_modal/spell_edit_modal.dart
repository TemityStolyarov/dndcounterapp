import 'package:dndcounterapp/components/card/character_modal/spell_edit_spell_modal.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SpellEditModal {
  final Box box;
  final int index;
  final VoidCallback onDeleteSpell;
  final VoidCallback onEditSpell;

  SpellEditModal({
    required this.box,
    required this.index,
    required this.onDeleteSpell,
    required this.onEditSpell,
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
                  context: context,
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
    required BuildContext context,
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
                              ' (${spells[i].cast! + spells[i].castModifier!}/${spells[i].cast}, ${spells[i].dice}d${spells[i].dmg} DMG)'),
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
                    if (spells[i].energyOnCast != null &&
                        spells[i].energyDescription != null)
                      const SizedBox(height: 4),
                    if (spells[i].energyOnCast != null &&
                        spells[i].energyDescription != null)
                      Text(
                          'При применении -${spells[i].energyOnCast} ${spells[i].energyDescription}'),
                    const SizedBox(height: 4),
                    uppercaseFirst(spells[i].description).isNotEmpty
                        ? Text(uppercaseFirst(spells[i].description))
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  final spellEditSpellModal = SpellEditSpellModal(
                    box: box,
                    index: index,
                    spellIndex: i,
                    onEditSpell: onEditSpell,
                  );
                  spellEditSpellModal.show(context);
                },
                child: Container(
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
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  final Character character = box.getAt(index);
                  List<Spell> spellbook = spells;
                  spellbook.removeAt(i);
                  final Character changedCharacter = character.copyWith(
                    spells: spellbook,
                  );
                  box.putAt(index, changedCharacter);
                  _onDelete();
                  Navigator.of(context).pop();
                },
                child: Container(
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
              ),
            ],
          ),
        ),
      );
      list.add(card);
    }
    return list;
  }

  void _onDelete() {
    onDeleteSpell();
    print('Spell deleted!');
  }
}
