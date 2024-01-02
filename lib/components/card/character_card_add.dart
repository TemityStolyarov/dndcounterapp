import 'package:dndcounterapp/components/card/character_modal/character_add_modal.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CharacterCardAdd extends StatelessWidget {
  final Box box;
  final bool colorScheme;
  final VoidCallback onAdd;

  const CharacterCardAdd({
    super.key,
    required this.box,
    required this.colorScheme,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          color: ColorPalette.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme
                  ? ColorPalette.alternativeshadowColor
                  : ColorPalette.shadowColor,
              offset: const Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 4,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          onTap: () {
            final characterAddModal = CharacterAddModal(
              box: box,
              onAdd: onAdd,
            );
            characterAddModal.show(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.add,
                  color: ColorPalette.alternativeshadowColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
