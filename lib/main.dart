import 'package:dndcounterapp/components/card/character_card.dart';
import 'package:dndcounterapp/components/card/character_card_add.dart';
import 'package:dndcounterapp/components/card/character_modal/image_update_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/character_edit_modal.dart';
import 'package:dndcounterapp/components/dice_row/dice_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(WeaponAdapter());
  Hive.registerAdapter(SpellAdapter());
  await Hive.openBox<Character>('characters');
  Box<Character> box = Hive.box<Character>('characters');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.brown)),
    home: MainApp(box: box),
  ));
}

class MainApp extends StatefulWidget {
  final Box<Character> box;
  const MainApp({super.key, required this.box});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool colorScheme = true;
  List<Character> chars = [];
  String json = '';

  @override
  void initState() {
    _updateCards();
    super.initState();
  }

  @override
  void dispose() async {
    await widget.box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      json = jsonEncode(chars.map((person) => person.toJson()).toList());
    });
    return Scaffold(
      backgroundColor: colorScheme
          ? ColorPalette.alternativeBackgroundColor
          : ColorPalette.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 100),
        child: DiceRow(
          json: json,
          box: widget.box,
          onImport: _updateCards,
          chars: chars,
          colorScheme: colorScheme,
          childSwitch: Switch.adaptive(
            activeColor: ColorPalette.accentColor,
            splashRadius: 0,
            value: colorScheme,
            onChanged: (value) {
              setState(() {
                colorScheme = value;
              });
            },
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topRight,
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      for (int index = 0; index < chars.length; index++)
                        CharacterCard(
                          colorScheme: colorScheme,
                          character: chars[index],
                          box: widget.box,
                          index: index,
                          onClose: () {
                            widget.box.deleteAt(index);
                            _updateCards();
                          },
                          onEdit: () {
                            final characterEditModal = CharacterEditModal(
                              box: widget.box,
                              onSave: _updateCards,
                              index: index,
                            );
                            characterEditModal.show(context);
                          },
                          onPlus: () {
                            widget.box.putAt(
                              index,
                              chars[index].copyWith(
                                hpModifier: chars[index].hpModifier + 1,
                              ),
                            );
                            _updateCards();
                          },
                          onMinus: () {
                            widget.box.putAt(
                              index,
                              chars[index].copyWith(
                                hpModifier: chars[index].hpModifier - 1,
                              ),
                            );
                            _updateCards();
                          },
                          onReturnDefaultHP: () {
                            widget.box.putAt(
                              index,
                              chars[index].copyWith(
                                hpModifier: 0,
                              ),
                            );
                            _updateCards();
                          },
                          onAddItem: _updateCards,
                          onAddSpell: _updateCards,
                          onEditItem: _updateCards,
                          onEditSpell: _updateCards,
                          onDeleteItem: _updateCards,
                          onDeleteSpell: _updateCards,
                          onChangingModifierValue: _updateCards,
                          onImageUpdate: () {
                            final imageUpdateModal = ImageUpdateModal(
                              box: widget.box,
                              index: index,
                              onImageUpdate: _updateCards,
                            );
                            imageUpdateModal.show(context);
                          },
                        ),
                      CharacterCardAdd(
                        colorScheme: colorScheme,
                        box: widget.box,
                        onAdd: _updateCards,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateCards() {
    setState(() {
      chars = widget.box.values.toList();
    });
  }
}
