import 'dart:math';

import 'package:dndcounterapp/components/card/character_modal/charbook_add_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/charbook_edit_modal.dart';
import 'package:dndcounterapp/components/card/character_modal/coins_modal.dart';
import 'package:dndcounterapp/components/charbook_widget.dart';
import 'package:dndcounterapp/components/dice_row/dice_row.dart';
import 'package:dndcounterapp/core/models/character.dart';
import 'package:dndcounterapp/core/models/charbook.dart';
import 'package:dndcounterapp/core/models/spell.dart';
import 'package:dndcounterapp/core/models/weapon.dart';
import 'package:dndcounterapp/core/ui_kit/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CharBookAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(WeaponAdapter());
  Hive.registerAdapter(SpellAdapter());
  await Hive.openBox<CharBook>('charbook');
  Box<CharBook> box = Hive.box<CharBook>('charbook');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.brown)),
    home: MainApp(box: box),
  ));
}

class MainApp extends StatefulWidget {
  final Box<CharBook> box;
  const MainApp({super.key, required this.box});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool colorScheme = true;
  List<CharBook> charbooks = [];
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

  void _updateCards() {
    setState(() {
      charbooks = widget.box.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      json =
          jsonEncode(charbooks.map((charbook) => charbook.toJson()).toList());
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
          charBooks: charbooks,
          colorScheme: colorScheme,
          // childSwitch: Switch.adaptive(
          //   activeColor: ColorPalette.accentColor,
          //   splashRadius: 0,
          //   value: colorScheme,
          //   onChanged: (value) {
          //     setState(() {
          //       colorScheme = value;
          //     });
          //   },
          // ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  for (int charbookIndex = 0;
                      charbookIndex < charbooks.length;
                      charbookIndex++)
                    _CharbookCard(
                      charbookIndex: charbookIndex,
                      charbooks: charbooks,
                      charbookBox: widget.box,
                      colorScheme: colorScheme,
                      onStartBattleTap: () {
                        List<Character> presavedChars =
                            charbooks[charbookIndex].chars;
                        List<Character> battableChars = [];
                        List<Character> unbattableChars = [];
                        for (int index = 0;
                            index < presavedChars.length;
                            index++) {
                          if (presavedChars[index].isEnabled == true) {
                            presavedChars[index] =
                                presavedChars[index].copyWith(
                              initiativeBeforeBattle: index,
                              initiative: Random().nextInt(20) + 1,
                            );
                          } else {
                            presavedChars[index] =
                                presavedChars[index].copyWith(
                              initiativeBeforeBattle: index,
                              initiative: -1,
                            );
                          }

                          if (presavedChars[index].isEnabled) {
                            battableChars.add(presavedChars[index]);
                          } else {
                            unbattableChars.add(presavedChars[index]);
                          }
                        }
                        List<Character> sortingResult = [];
                        battableChars.sort((a, b) {
                          return a.initiative!.compareTo(b.initiative!);
                        });
                        sortingResult.addAll(battableChars.reversed);
                        sortingResult.addAll(unbattableChars);
                        CharBook result = charbooks[charbookIndex].copyWith(
                          chars: sortingResult,
                        );
                        widget.box.putAt(charbookIndex, result);
                        _updateCards();
                      },
                      onEndBattleTap: () {
                        List<Character> presavedChars =
                            charbooks[charbookIndex].chars;
                        List<Character> sortingResult = [];
                        for (Character char in presavedChars) {
                          final nulledInitChar = char.copyWith(
                            initiative: -1,
                          );
                          sortingResult.add(nulledInitChar);
                          print(nulledInitChar.initiative);
                        }
                        sortingResult.sort((a, b) {
                          return a.initiativeBeforeBattle!
                              .compareTo(b.initiativeBeforeBattle!);
                        });
                        CharBook result = charbooks[charbookIndex].copyWith(
                          chars: sortingResult,
                        );
                        widget.box.putAt(charbookIndex, result);
                        _updateCards();
                      },
                      onTapCoins: () {
                        final coinsModal = CoinsModal(
                          charbookBox: widget.box,
                          charbooks: charbooks,
                          charbookIndex: charbookIndex,
                          onCoinsUpdate: _updateCards,
                        );
                        coinsModal.show(context);
                      },
                      onTapSection: () {
                        final sectionEditModal = CharbookEditModal(
                          box: widget.box,
                          charbookIndex: charbookIndex,
                          onUpdateScreen: _updateCards,
                        );
                        sectionEditModal.show(context);
                      },
                      onUpdateScreen: _updateCards,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                      top: 40,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () {
                          final charbookAddModal = CharbookAddModal(
                            box: widget.box,
                            onAdd: _updateCards,
                          );
                          charbookAddModal.show(context);
                        },
                        tooltip: 'Добавить раздел',
                        backgroundColor: ColorPalette.cardColor,
                        child: const Icon(
                          Icons.add,
                          color: ColorPalette.alternativeshadowColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CharbookCard extends StatelessWidget {
  final int charbookIndex;
  final Box charbookBox;
  final List<CharBook> charbooks;
  final bool colorScheme;
  final VoidCallback onTapSection;
  final VoidCallback onUpdateScreen;
  final VoidCallback onTapCoins;
  final VoidCallback onStartBattleTap;
  final VoidCallback onEndBattleTap;

  const _CharbookCard({
    required this.charbookIndex,
    required this.charbooks,
    required this.charbookBox,
    required this.colorScheme,
    required this.onTapSection,
    required this.onUpdateScreen,
    required this.onTapCoins,
    required this.onStartBattleTap,
    required this.onEndBattleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTapSection,
              child: Container(
                width: 380,
                decoration: BoxDecoration(
                  color: ColorPalette.backgroundSectionName,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      charbooks[charbookIndex].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.fontBaseColor,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: onTapCoins,
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  color: ColorPalette.backgroundSectionName,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          charbooks[charbookIndex].coins == null
                              ? '0'
                              : charbooks[charbookIndex].coins.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.fontBaseColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset('assets/icons/coin.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: ColorPalette.backgroundSectionName,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Инициатива:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.fontBaseColor,
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: onStartBattleTap,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: SvgPicture.asset('assets/icons/battle.svg'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: onEndBattleTap,
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              SvgPicture.asset('assets/icons/end_battle.svg'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            children: [
              CharbookWidget(
                charbooks: charbooks,
                charbookBox: charbookBox,
                charbookIndex: charbookIndex,
                colorScheme: colorScheme,
                onUpdateScreen: onUpdateScreen,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
