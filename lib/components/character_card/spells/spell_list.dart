import 'package:dndcounterapp/components/character_card/character_modal/spell_edit_spell_modal.dart';
import 'package:dndcounterapp/components/character_card/spells/spell_list_item.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterSpellList extends StatelessWidget {
  const CharacterSpellList({
    super.key,
    required this.spells,
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.characterIndex,
    required this.onEditItem,
  });

  final List<Spell> spells;
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int characterIndex;
  final VoidCallback onEditItem;

  @override
  Widget build(BuildContext context) {
    //
    // TODO: IMPLEMENT AUTO SORTING (NOW IS MANUAL)
    //
    List<Spell> containsDescription = [];
    List<Spell> containsLongDescription = [];
    List<Spell> nonContainsDescription = [];
    for (int index = 0; index < spells.length; index++) {
      if (spells[index].description == null ||
          spells[index].description!.isEmpty) {
        nonContainsDescription.add(spells[index]);
      } else {
        if (spells[index].description!.length > 35) {
          containsLongDescription.add(spells[index]);
        } else {
          containsDescription.add(spells[index]);
        }
      }
    }
    List<Spell> finalList = [];
    finalList.addAll(nonContainsDescription);
    finalList.addAll(containsDescription);
    finalList.addAll(containsLongDescription);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Wrap(
        children: [
          for (int index = 0; index < finalList.length; index++)
            ChatacterSpellListItem(
              spell: finalList[index],
              index: index,
              onSpellItemTap: () {
                final inventoryIndex = spells.indexOf(finalList[index]);
                final inventoryEditSpellModal = SpellEditSpellModal(
                  charbookBox: charbookBox,
                  charbooks: charbooks,
                  charbookIndex: charbookIndex,
                  index: characterIndex,
                  spellIndex: inventoryIndex,
                  onEditSpell: onEditItem,
                );
                inventoryEditSpellModal.show(context);
              },
            ),
        ],
      ),
    );
  }
}
