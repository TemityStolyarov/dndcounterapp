import 'package:dndcounterapp/components/character_card/character_modal/inventory_edit_modal.dart';
import 'package:dndcounterapp/components/character_card/weapons/weapon_list_item.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterWeaponList extends StatelessWidget {
  const CharacterWeaponList({
    super.key,
    required this.inventory,
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.characterIndex,
    required this.onEditItem,
  });

  final List<Weapon> inventory;
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
    List<Weapon> containsDescription = [];
    List<Weapon> containsLongDescription = [];
    List<Weapon> nonContainsDescription = [];
    for (int index = 0; index < inventory.length; index++) {
      if (inventory[index].description == null ||
          inventory[index].description!.isEmpty) {
        nonContainsDescription.add(inventory[index]);
      } else {
        if (inventory[index].description!.length > 45) {
          containsLongDescription.add(inventory[index]);
        } else {
          containsDescription.add(inventory[index]);
        }
      }
    }
    List<Weapon> finalList = [];
    finalList.addAll(containsLongDescription);
    finalList.addAll(containsDescription);
    finalList.addAll(nonContainsDescription);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Wrap(
        children: [
          for (int index = 0; index < finalList.length; index++)
            ChatacterWeaponListItem(
              weapon: finalList[index],
              index: index,
              onWeaponItemTap: () {
                final inventoryIndex = inventory.indexOf(finalList[index]);
                final inventoryEditItemModal = InventoryEditModal(
                  charbookBox: charbookBox,
                  charbooks: charbooks,
                  charbookIndex: charbookIndex,
                  index: characterIndex,
                  itemIndex: inventoryIndex,
                  onEditItem: onEditItem,
                );
                inventoryEditItemModal.show(context);
              },
            ),
        ],
      ),
    );
  }
}
