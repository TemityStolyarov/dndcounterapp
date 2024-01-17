import 'package:dndcounterapp/components/character_card/character_modal/inventory_edit_item_modal.dart';
import 'package:dndcounterapp/core/helpers.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryEditModal {
  final Box charbookBox;
  final List<CharBook> charbooks;
  final int charbookIndex;
  final int index;

  final VoidCallback onDeleteItem;
  final VoidCallback onEditItem;

  InventoryEditModal({
    required this.charbookBox,
    required this.charbooks,
    required this.charbookIndex,
    required this.index,
    required this.onDeleteItem,
    required this.onEditItem,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final Character char = charbooks[charbookIndex].chars[index];
        return AlertDialog(
          title: const Text('Редактирование инвентаря'),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _inventoryToList(
                  items: char.inventory,
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
              child: const Text('Отменить'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _inventoryToList({
    required List<Weapon> items,
    required BuildContext context,
  }) {
    List<Widget> list = [];

    for (int i = 0; i < items.length; i++) {
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
                        SizedBox(
                          width: 340,
                          child: Text(
                            items[i].name,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (items[i].dice != null &&
                        items[i].dmg != null &&
                        items[i].kd != null)
                      Text(
                          '${items[i].dice}d${items[i].dmg} DMG, ${items[i].kd} AR'),
                    if (items[i].dice != null &&
                        items[i].dmg != null &&
                        items[i].kd == null)
                      Text('${items[i].dice}d${items[i].dmg} DMG'),
                    if (items[i].dice == null &&
                        items[i].dmg == null &&
                        items[i].kd != null)
                      Text('${items[i].kd} AR'),
                    uppercaseFirst(items[i].description).isNotEmpty
                        ? Text(uppercaseFirst(items[i].description))
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  final inventoryEditItemModal = InventoryEditItemModal(
                    charbookBox: charbookBox,
                    charbooks: charbooks,
                    charbookIndex: charbookIndex,
                    index: index,
                    itemIndex: i,
                    onEditItem: onEditItem,
                  );
                  inventoryEditItemModal.show(context);
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
                  List<Character> charList = charbooks[charbookIndex].chars;
                  charList[index].inventory.removeAt(i);
                  final CharBook updatedCharbook =
                      charbooks[charbookIndex].copyWith(chars: charList);
                  charbookBox.putAt(charbookIndex, updatedCharbook);

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
    onDeleteItem();
    print('Item deleted!');
  }
}
