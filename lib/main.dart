import 'package:dndcounterapp/components/card/character_card.dart';
import 'package:dndcounterapp/components/card/character_card_add.dart';
import 'package:dndcounterapp/components/dice.dart';
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
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool colorScheme = true;
  List<Character> chars = [];
  Box<Character> box = Hive.box<Character>('characters');
  // final box = Hive.openBox('chars').then((value) {
  //   chars.add(value.values.);
  // });

  @override
  void initState() {
    _getDataFromHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Character char = Character(
    //   name: 'Хельга Галтунг',
    //   race: 'Высший эльф',
    //   crClass: 'Жрец',
    //   hp: 20,
    //   kd: 10,
    //   strength: 20,
    //   agility: 18,
    //   intelligence: 16,
    //   athletics: 14,
    //   charisma: 12,
    //   wisdom: 10,
    //   description: 'Creating story',
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Inter',
          colorScheme:
              const ColorScheme.light().copyWith(primary: Colors.brown)),
      home: Scaffold(
        backgroundColor: colorScheme
            ? ColorPalette.alternativeBackgroundColor
            : ColorPalette.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(0, 100),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Save',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () async {
                        await box.close();
                        await Hive.openBox<Character>('characters');
                        box = Hive.box<Character>('characters');
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorPalette.attAgility,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
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
                              Icons.save,
                              color: ColorPalette.fontBaseColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Text(
                      'Update',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onTap: () {
                        setState(() {
                          box = Hive.box<Character>('characters');
                          chars = box.values.toList();
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ColorPalette.cubeColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
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
                              Icons.refresh,
                              color: ColorPalette.fontBaseColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
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
                const Spacer(),
                Switch.adaptive(
                  activeColor: ColorPalette.accentColor,
                  splashRadius: 0,
                  value: colorScheme,
                  onChanged: (value) => {
                    setState(
                      () {
                        colorScheme = value;
                      },
                    )
                  },
                ),
              ],
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
                            box: box,
                            index: index,
                            onClose: () {
                              box.deleteAt(index);
                              setState(() {
                                chars = box.values.toList();
                              });
                            },
                          ),
                        CharacterCardAdd(
                          colorScheme: colorScheme,
                          box: box,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getDataFromHive() {
    final box = Hive.box<Character>('characters');

    setState(() {
      chars = box.values.toList();
    });

    // await box.close();
  }
}
