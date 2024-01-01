import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InventoryEditModal {
  final Box box;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  InventoryEditModal({
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
          title: const Text('Редактирование инвентаря'),
          content: SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _inventoryToList(
                  items: char.inventory,
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

  List<Widget> _inventoryToList({
    required List<Weapon> items,
    required int characterIndex,
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
                        Text(
                          items[i].name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if (items[i].dice != null &&
                            items[i].dmg != null &&
                            items[i].kd != null)
                          Text(
                              ' (${items[i].dice}d${items[i].dmg} DMG, ${items[i].kd} AR)'),
                        if (items[i].dice != null &&
                            items[i].dmg != null &&
                            items[i].kd == null)
                          Text(' (${items[i].dice}d${items[i].dmg} DMG)'),
                        if (items[i].dice == null &&
                            items[i].dmg == null &&
                            items[i].kd != null)
                          Text(' (${items[i].kd} AR)'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    items[i].description != null
                        ? Text(items[i].description!)
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
