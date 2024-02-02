import 'package:dndcounterapp/components/character_card/character_modal/input_output_modal.dart';
import 'package:dndcounterapp/components/dice_row/dice.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DiceRow extends StatelessWidget {
  final bool colorScheme;
  final Widget? childSwitch;
  final String json;
  final VoidCallback onImport;
  final Box box;
  final List<CharBook> charBooks;

  const DiceRow({
    super.key,
    required this.colorScheme,
    this.childSwitch,
    required this.json,
    required this.onImport,
    required this.box,
    required this.charBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              final inputOutputModal = CharacterIOModal(
                box: box,
                onImport: onImport,
                json: json,
                charBooks: charBooks,
              );
              inputOutputModal.show(context);
            },
            child: Column(
              children: [
                const Text(
                  'i/o',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorPalette.attCharisma,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: ColorPalette.fontBaseColor.withOpacity(0.7),
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
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.import_export_rounded,
                        color: ColorPalette.fontBaseColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Column(
            children: [
              const Text(
                'd100',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 100, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd20',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 20, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd12',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 12, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd10',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 10, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd8',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 8, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd6',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 6, colorScheme: colorScheme),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'd4',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Dice(d: 4, colorScheme: colorScheme),
            ],
          ),
        ],
      ),
    );
  }
}
