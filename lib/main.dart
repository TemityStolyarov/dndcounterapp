import 'package:dndcounterapp/components/card/character_card.dart';
import 'package:dndcounterapp/components/card/character_card_add.dart';
import 'package:dndcounterapp/components/card/character_description_blocks/character_main_modal_edit.dart';
import 'package:dndcounterapp/components/dice_row.dart';
import 'package:dndcounterapp/models/character.dart';
import 'package:dndcounterapp/models/spell.dart';
import 'package:dndcounterapp/models/weapon.dart';
import 'package:dndcounterapp/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  @override
  void initState() {
    _getDataFromHive();
    super.initState();
  }

  @override
  void dispose() async {
    await widget.box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   inventory: [
    //     Weapon(
    //       name: 'Крутой меч',
    //       dice: 3,
    //       dmg: 6,
    //       description: '',
    //     ),
    //     Weapon(
    //       name: 'Крутой меч2',
    //       dice: 3,
    //       dmg: 6,
    //       description: 'CRAZY!',
    //     ),
    //     Weapon(
    //       name: 'Щит',
    //       kd: 4,
    //     ),
    //     Weapon(
    //       name: 'Кольчуга',
    //       kd: 2,
    //     ),
    //   ],
    //   spells: [
    //     Spell(
    //       name: 'Каст',
    //       dice: 2,
    //       dmg: 10,
    //     ),
    //   ],
    // );

    return Scaffold(
      backgroundColor: colorScheme
          ? ColorPalette.alternativeBackgroundColor
          : ColorPalette.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size(0, 100),
        child: DiceRow(
          colorScheme: colorScheme,
          child: Switch.adaptive(
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
                            setState(() {
                              chars = widget.box.values.toList();
                            });
                          },
                          onEdit: () {
                            final cmme = CharacterMainModalEdit(
                              box: widget.box,
                              onSave: _getDataFromHive,
                              index: index,
                            );
                            cmme.showCharacterMainModalEdit(context);
                          },
                        ),
                      CharacterCardAdd(
                        colorScheme: colorScheme,
                        box: widget.box,
                        onAdd: () {
                          setState(() {
                            chars = widget.box.values.toList();
                          });
                        },
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

  void _getDataFromHive() {
    setState(() {
      chars = widget.box.values.toList();
    });
  }
}
